<?php

class Home extends Controller
{

    public function index()
    {
        $this->output('home');
    }


    public function error()
    {
        if ($this->is_api())
            $this->response([
                'success' => 'false',
                "error" => "unknown"
            ], 'json');
        else
            $this->output('error');
    }

    public function dashboard()
    {
        echo 'pp';
    }

    public function login()
    {
        if (isset($_GET['username']) && !empty($_GET['username']) && isset($_GET['password']) && !empty($_GET['password'])) {
            $this->db->where("user_name", $_GET['username']);
            $results = $this->db->get('users');
            if ($results) {
                if (password_verify($_GET['password'], $results[0]['password'])) {
                    $rand_token = openssl_random_pseudo_bytes(64);
                    //change binary to hexadecimal
                    $token = bin2hex($rand_token);
                    //token generated
                    $this->db->where("user_id", $results[0]['user_id'])
                        ->update("api_keys", ["is_active" => 0]); //only one session at a time
                    $this->db->insert("api_keys", [
                        "api_key" => $token,
                        "user_id" => $results[0]['user_id'],
                        "is_active" => 1,
                        "expires_at" => $this->db->now('+1d')
                    ]);
                    $this->response([
                        "success" => "true",
                        "api_token" => $token
                    ], "json");
                } else {
                    $this->response([
                        'success' => 'false',
                        'error' => 'Invalid Credentials'
                    ], 'json');
                }
            } else {
                $this->response([
                    'success' => 'false',
                    'error' => 'Invalid Credentials'
                ], 'json');
            }
        } else {
            $this->response([
                'success' => 'false',
                'error' => 'Incorrect parameters'
            ], 'json');
        }
    }

    public function register()
    {
        $timeTarget = 0.05; // 50 milliseconds
        $cost = 8;
        do {
            $cost++;
            $start = microtime(true);
            password_hash("test", PASSWORD_BCRYPT, ["cost" => $cost]);
            $end = microtime(true);
        } while (($end - $start) < $timeTarget);
        echo password_hash("test", PASSWORD_BCRYPT, ["cost" => $cost]);
    }
}
