<?php namespace Acme;


class eReaderAdapter implements BookInterface
{

    private $reader;

    public function __construct(eReaderInterface $kindle)
    {

        $this->reader = $kindle;
    }

    public function open()
    {
        return $this->reader->turnOn();
    }

    public function turnPage()
    {
        return $this->reader->pressNextButton();
    }
}