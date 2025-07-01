<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Product;
use App\Form\ProductType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ProductController extends AbstractController
{
    #[Route('/product', name: 'app_product')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        $products = $entityManager->getRepository(Product::class)->findAll();
        return $this->render('product/index.html.twig', [
            'products' => $products,
            'label' => 'Producten'
        ]);
    }

    #[Route('/product/{id}', name: 'app_product_detail')]
    public function detail(EntityManagerInterface $entityManager, int $id): Response
    {
        $product = $entityManager->getRepository(Product::class)->find($id);
        return $this->render('product/detail.html.twig', [
            'product' => $product,
        ]);
    }

    #[Route('/product-add', name: 'app_product_add')]
    public function add(Request $request, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(ProductType::class);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $product = $form->getData();
            $entityManager->persist($product);
            $entityManager->flush();

            $this->addFlash('success', 'Het product is toegevoegd');

            return $this->redirectToRoute('app_product');
        }

        return $this->render('product/add.html.twig', [
            'form' => $form
        ]);
    }

    #[Route('/product-update/{id}', name: 'app_product_update')]
    public function update(Request $request, EntityManagerInterface $entityManager, int $id): Response
    {
        $product = $entityManager->getRepository(Product::class)->find($id);
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $product = $form->getData();
            $entityManager->persist($product);
            $entityManager->flush();

            $this->addFlash('success', 'Het product is bijgewerkt');

            return $this->redirectToRoute('app_product');
        }

        return $this->render('product/update.html.twig', [
            'form' => $form
        ]);
    }

    #[Route('/product-delete/{id}', name: 'app_product_delete')]
    public function delete(EntityManagerInterface $entityManager, int $id): Response
    {
        $product = $entityManager->getRepository(Product::class)->find($id);

        $entityManager->remove($product);
        $entityManager->flush();

        $this->addFlash('danger', 'Het product is verwijderd');

        return $this->redirectToRoute('app_product');
    }

    #[Route('/category-product/{id}', name: 'app_category_product')]
    public function viewCategoryProducts(EntityManagerInterface $entityManager, int $id): Response
    {
        $category = $entityManager->getRepository(Category::class)->find($id);
        $products = $category->getProducts();
        return $this->render('product/category-product.html.twig', [
            'products' => $products,
            'label' => $category->getName()
        ]);
    }
}
