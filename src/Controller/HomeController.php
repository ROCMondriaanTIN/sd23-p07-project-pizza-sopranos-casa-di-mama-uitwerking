<?php

namespace App\Controller;

use App\Entity\Category;
use App\Repository\CategoryRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(EntityManagerInterface $entityManager): Response
    {

        if($this->isGranted('ROLE_ADMIN')){
            $this->redirectToRoute('app_purchase');
        }

        $categories = $entityManager->getRepository(Category::class)->findAll();
        return $this->render('home/index.html.twig', [
            'categories' => $categories,
        ]);
    }
}
