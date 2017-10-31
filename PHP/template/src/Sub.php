<?php
namespace App;

abstract class Sub
{
    public function make()
    {
        return $this
            ->layBread()
            ->addLettuce()
            ->addPrimaryToppings()
            ->addSauces();
    }

    protected function layBread()
    {
        var_dump('laying down break');

        return $this;
    }

    protected function addLettuce()
    {
        var_dump('add some lettuce');

        return $this;
    }

    protected function addSauces()
    {
        var_dump('add some sauces');

        return $this;
    }

    protected abstract function addPrimaryToppings();
}
