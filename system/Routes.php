<?php

class Routes
{
    protected $routes = [
        "home" => "index@Home",
        "error" => "error@Home",
        "login" => "login@Home",
        "register" => "register@Home",

        "api/doors/all" => "all@Door",
        "api/doors/add" => "add@Door",
        "api/doors/delete" => "delete@Door",
        "api/doors/edit" => "edit@Door",

        "api/users/add" => "add@User",
        "api/users/edit" => "edit@User",
        "api/users/activate" => "activate@User",
        "api/users/delete" => "delete@User",

        "api/cards/all" => "all@Card",
        "api/cards/add" => "add@Card",
        "api/cards/update" => "update@Card",
        "api/cards/delete" => "delete@Card",

        "api/levels/all" => "all@Level",
        "api/levels/add" => "add@Level",
        "api/levels/delete" => "delete@Level",

        "api/dashboard" => "dashboard@Home",

        "api/logs/all" => "all@Log",
        "api/logs/investigate" => "investigate@Log",

        "api/access/all" => "all@Access"

    ];

    protected function routeExists($route)
    {
        if (array_key_exists($route, $this->routes)) {
            return true;
        } else {
            return false;
        }
    }

    public function getControllerAndMethod($route)
    {
        if (!$this->routeExists($route))
            return false;
        $ControllerAndMethod = $this->routes[$route];
        $ControllerAndMethod = explode('@', $ControllerAndMethod);
        if (!file_exists(ROOT . '/controllers/' . $ControllerAndMethod[1] . '.php'))
            return false;

        return [
            "Controller" => $ControllerAndMethod[1],
            "Method" => $ControllerAndMethod[0]
        ];
    }
}