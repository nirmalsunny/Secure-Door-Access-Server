<?php

class App
{

    public $routes;
    public $db;
    public $request_id;
    public $user_id;

    protected $controller;
    protected $method;

    public function __construct($route)
    {
        $this->db = new MysqliDb(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT);

        if (isset($_GET['route']) && explode('/', $_GET['route'])[0] == 'api')
            $this->auth();
        $this->routes = new Routes();
        $ControllerAndMethod = $this->routes->getControllerAndMethod($route);
        if ($ControllerAndMethod) {
            $this->controller = $ControllerAndMethod['Controller'];
            $this->method = $ControllerAndMethod['Method'];
            if (false !== strpos($_SERVER['HTTP_USER_AGENT'], 'ESP8266HTTPClient'))
            (new DumpHTTPRequestToFile)->execute('./arduino.txt');
            else
            (new DumpHTTPRequestToFile)->execute('./dumprequest.txt');
        } else {
            $this->controller = "Home";
            $this->method = "error";
            (new DumpHTTPRequestToFile)->execute('./errorrequest.txt');
            //header('HTTP/1.1 404 Not Found');
            echo "controller or method not found";
        }
    }

    public function run()
    {
        include ROOT . '/controllers/' . $this->controller . '.php';
        $controller = new $this->controller();
        if (!method_exists($controller, $this->method)) {
            header('Location: ' . ROOT_URL . '/error');
        }
        is_callable($controller->{$this->method}()) ?? $controller->{$this->method}();
    }

    protected function auth()
    {
        $data = array(
            "request_header" => json_encode(getallheaders()),
            "request_body" => json_encode($_REQUEST),
            "request_time" => $this->db->now()
        );


        if (!$this->verify_credentials()) {
            $response = ['error' => 'unauthorized'];
            $data['response'] = json_encode([
                'status_code' => 401,
                'body' => $response
            ]);
            $data['response_time'] = $this->db->now();
            header('HTTP/1.1 401 Unauthorized');

            $id = $this->db->insert('requests', $data);
            if ($id)
                $this->request_id = $id;
            $response['request-id'] = $id;
            echo json_encode($response);
            exit();
        }
    }

    protected function verify_credentials()
    {
        if (isset(getallheaders()['x-authorization-token'])) {
            //print_r(getallheaders());
            if (getallheaders()['x-authorization-token'] == "abcd")
                return true;
            else
                return false;
            // $this->db->where("api_key", getallheaders()['x-authorization-token'])
            //     ->where("expires_at > NOW()")
            //     ->where("is_active", 1);
            // $user_id = $this->db->get('api_keys', 1);
            // if ($user_id) {
            //     $this->user_id = $user_id;
            //     return true;
            // } else {
            //     return false;
            // }
        } else {
            return false;
        }
    }
}

class DumpHTTPRequestToFile
{
    public function execute($targetFile)
    {
        $data = sprintf(
            "%s %s %s\n\nHTTP headers:\n",
            $_SERVER['REQUEST_METHOD'],
            $_SERVER['REQUEST_URI'],
            $_SERVER['SERVER_PROTOCOL']
        );
        $data .= "IP: " . $_SERVER['REMOTE_ADDR'] . "\n";
        foreach ($this->getHeaderList() as $name => $value) {
            $data .= $name . ': ' . $value . "\n";
        }

        $data .= "\nRequest post:\n";
        foreach ($_POST as $key => $value) {
            $data .= $key . ': ' . $value . "\n";
        }

        $data .= "\nRequest get:\n";
        foreach ($_GET as $key => $value) {
            $data .= $key . ': ' . $value . "\n";
        }

        $data .= "\nRequest body:\n";

        file_put_contents(
            $targetFile,
            $data . file_get_contents('php://input') . "\n" . '-------------------------' . "\n",
            FILE_APPEND
        );
    }

    private function getHeaderList()
    {
        $headerList = [];
        foreach ($_SERVER as $name => $value) {
            if (preg_match('/^HTTP_/', $name)) {
                // convert HTTP_HEADER_NAME to Header-Name
                $name = strtr(substr($name, 5), '_', ' ');
                $name = ucwords(strtolower($name));
                $name = strtr($name, ' ', '-');

                // add to list
                $headerList[$name] = $value;
            }
        }

        return $headerList;
    }
}
