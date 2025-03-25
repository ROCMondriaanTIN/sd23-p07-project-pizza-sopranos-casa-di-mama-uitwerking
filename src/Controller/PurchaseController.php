<?php

namespace App\Controller;

use App\Entity\Product;
use App\Entity\Purchase;
use App\Entity\PurchaseProduct;
use App\Form\PurchaseType;
use App\Service\ShoppingCartService;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class PurchaseController extends AbstractController
{
    #[IsGranted('ROLE_USER')]
    #[Route('/purchase', name: 'app_purchase')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        if($this->isGranted("ROLE_ADMIN")){
            $purchases = $entityManager->getRepository(Purchase::class)->findAll();
        } else{
            $purchases = $entityManager->getRepository(Purchase::class)->findBy(['user' => $this->getUser()]);
        }

        return $this->render('purchase/index.html.twig', [
            'purchases' => $purchases,
        ]);
    }

    #[IsGranted('ROLE_USER')]
    #[Route('/purchase/{id}', name: 'app_purchase_detail')]
    public function detail(EntityManagerInterface $entityManager, int $id): Response
    {
        $purchase = $entityManager->getRepository(Purchase::class)->find($id);

        return $this->render('purchase/detail.html.twig', [
            'purchase' => $purchase,
        ]);
    }

    #[IsGranted('ROLE_USER')]
    #[Route('/purchase-add', name: 'app_purchase_add')]
    public function add(Request $request, EntityManagerInterface $entityManager, ShoppingCartService $shoppingCartService): Response
    {
        $products = $shoppingCartService->getShoppingCartProducts($request);
        $totalPrice = $shoppingCartService->calculateTotalPrice($products);

        $form = $this->createForm(PurchaseType::class);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $purchase = $form->getData();
            foreach ($products as $shoppingCartProduct){
                $purchaseProduct = new PurchaseProduct();
                $product = $entityManager->getRepository(Product::class)->find($shoppingCartProduct->getProduct()->getId());
                $purchaseProduct->setProduct($product);
                $purchaseProduct->setPurchase($purchase);
                $purchaseProduct->setQuantity($shoppingCartProduct->getQuantity());
                $purchase->addPurchaseProduct($purchaseProduct);
            }
            $purchase->setUser($this->getUser());
            $purchase->setDate(new DateTime());
            $entityManager->persist($purchase);
            $entityManager->flush();

            $this->addFlash('success', 'De order is toegevoegd');

            $session = $request->getSession();
            $session->set('shopping_cart', []);

            return $this->redirectToRoute('app_home');
        }

        return $this->render('purchase/add.html.twig', [
            'form' => $form,
            'products' => $products,
            'totalPrice' => $totalPrice
        ]);
    }
}
