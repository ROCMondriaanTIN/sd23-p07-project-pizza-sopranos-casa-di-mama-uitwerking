<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Product;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
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
