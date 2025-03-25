<?php

namespace App\Service;

use Symfony\Component\HttpFoundation\Request;

class ShoppingCartService
{

    public function getShoppingCartProducts(Request $request): array{
        $session = $request->getSession();
        if(!$session->get('shopping_cart')){
            $session->set('shopping_cart', []);
        }
        return $session->get('shopping_cart');
    }

    public function calculateTotalPrice($products): float{
        $totalPrice = 0;

        foreach ($products as $shoppingCartProduct){
            $totalPrice = $totalPrice + ($shoppingCartProduct->getQuantity() * $shoppingCartProduct->getProduct()->getPrice());
        }
        return $totalPrice;
    }

    public function getNumberOfProducts(Request $request){
        $products = $this->getShoppingCartProducts($request);
        $totalNumberOfProducts = 0;

        foreach ($products as $shoppingCartProduct){
            $totalNumberOfProducts = $totalNumberOfProducts + $shoppingCartProduct->getQuantity();
        }
        return $totalNumberOfProducts;
    }
}