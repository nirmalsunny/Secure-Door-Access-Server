<?php

class User extends Controller
{

    public function add()
    {
        echo 'welcome';
    }

    public function edit()
    {
        echo 'welcome';
    }

    public function activate()
    {
        if (
            isset($_GET['user_id']) && !empty($_GET['user_id']) && is_numeric($_GET['user_id'])
            && isset($_GET['is_active']) && !empty($_GET['is_active']) && is_numeric($_GET['is_active'])
        ) {
            $activate = $this->db->where("user_id", $_GET['user_id'])
                ->update("users", ["is_active" => $_GET['is_active']]);
            if ($activate) {
                $this->response(['success' => 'true'], 'json');
            } else {
                $this->response(['success' => 'false'], 'json');
            }
        }
    }

    public function delete()
    {
        echo 'welcome';
    }
}
