<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class foodDrinkCard extends Component
{
    public $foodDrink;
    public function __construct($data)
    {
        $this->foodDrink = $data;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.food-drink-card');
    }
}
