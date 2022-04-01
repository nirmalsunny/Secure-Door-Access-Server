<?php

class Home extends Controller
{

    public function index()
    {
        $this->output('home');
    }

    public function test_me()
    {
        //echo json_encode(['open_door' => true]);
        // print_r(json_decode('{"firstName":"John","lastName":"Doe","emai":"john.doe@gmail.com","card":"123456789","doors":[1,2,4],"levels":[3],"expDate":"2020-01-01"}', true));
        //    print_r($_SERVER);
        //    print_r($_POST);
        //    print_r($_GET);
        //    print_r($_FILES);
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
        //
    }

    public function login()
    {
        if (isset($_GET['username']) && !empty($_GET['username']) && isset($_GET['password']) && !empty($_GET['password'])) {
            $this->db->where("user_name", $_GET['username']);
            $results = $this->db->get('users');
            if ($results) {
                if (password_verify($_GET['password'], $results[0]['password'])) {
                    $token = Helpers::token();
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
        //
    }
}
