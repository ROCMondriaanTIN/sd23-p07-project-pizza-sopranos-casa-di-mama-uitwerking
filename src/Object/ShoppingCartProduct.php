<?php

namespace App\Object;

use App\Entity\Product;

class ShoppingCartProduct
{
    // Properties
    public Product $product;
    public int $quantity;

    function getProduct(): Product{
        return $this->product;
    }

    function setProduct(Product $product): static{
        $this->product = $product;
        return $this;
    }

    function getQuantity(): int {
        return $this->quantity;
    }

    function setQuantity(int $quantity): static{
        $this->quantity = $quantity;
        return $this;
    }
}