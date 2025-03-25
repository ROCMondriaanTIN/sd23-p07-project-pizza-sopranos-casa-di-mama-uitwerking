<?php

namespace App\Controller;

use App\Entity\Product;
use App\Object\ShoppingCartProduct;
use App\Service\ShoppingCartService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class ShoppingCartController extends AbstractController
{
    #[IsGranted('ROLE_USER')]
    #[Route('/shopping/cart', name: 'app_shopping_cart')]
    public function index(Request $request, ShoppingCartService $shoppingCartService): Response
    {
        $products = $shoppingCartService->getShoppingCartProducts($request);
        $totalPrice = $shoppingCartService->calculateTotalPrice($products);

        return $this->render('shopping_cart/index.html.twig', [
            'products' => $products,
            'totalPrice' => $totalPrice
        ]);
    }

    #[IsGranted('ROLE_USER')]
    #[Route('/shopping/cart/add/{id}', name: 'app_add_shopping_cart')]
    public function add(int $id, Request $request, EntityManagerInterface $em): Response
    {
        $product = $em->getRepository(Product::class)->find($id);
        $session = $request->getSession();
        if(!$session->get('shopping_cart')){
            $session->set('shopping_cart', []);
        }
        $shoppingCart = $session->get('shopping_cart');
        $productExists = false;
        $shoppingCartProduct = null;
        foreach ($shoppingCart as $shoppingCartProduct){
            if($shoppingCartProduct->getProduct()->getId() === $id){
                $shoppingCartProduct->setQuantity($shoppingCartProduct->getQuantity() + 1);
                $productExists = true;
            }
        }
        if(!$productExists){
            $shoppingCartProduct = new ShoppingCartProduct();
            $shoppingCartProduct->setProduct($product);
            $shoppingCartProduct->setQuantity(1);
            $shoppingCart[] = $shoppingCartProduct;
        }

        $session->set('shopping_cart', $shoppingCart);
        $this->addFlash('success', 'Product is toegevoegd aan de winkelwagen');
        return $this->redirectToRoute('app_product_detail', ['id' => $product->getId()]);
    }

    #[IsGranted('ROLE_USER')]
    #[Route('/shopping/cart/delete/{id}', name: 'delete_cart_product')]
    public function deleteCartProduct(Request $request, int $id): Response
    {
        $session = $request->getSession();
        $products = $session->get('shopping_cart');

        $index = 0;
        $count = 0;
        $productToDelete = null;
        foreach ($products as $product) {
            if ($product->getProduct()->getId()==$id){
                $product->setQuantity($product->getQuantity() - 1);
                $index = $count;
                $productToDelete = $product;
            }
            $count++;
        }
        if($productToDelete->getQuantity() === 0) {
            array_splice($products, $index, 1);
            $session->set('shopping_cart', $products);
        }


        return $this->redirectToRoute('app_shopping_cart');
    }

    #[Route('/shopping/cart/delete-all', name: 'delete_cart_product_all')]
    public function destroyCart(Request $request): Response
    {
        $session = $request->getSession();

        $session->set('shopping_cart', []);

        return $this->redirectToRoute('app_shopping_cart');
    }


}
