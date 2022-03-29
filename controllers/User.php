<?php

class User extends Controller
{
    protected $error = [];
    
    public function add()
    {
        $validate = $this->validate_add_user();
        if ($validate) {
            $data = array(
                "first_name" => $_GET['first_name'],
                "last_name" => $_GET['last_name'],
                "email" => $_GET['email'],
                "allow_global_level_access" => ($_GET['type_of_access'] == 'Administrator' ? 1 : 0),
                "created_at" => $this->db->now(),
                "modified_at" => $this->db->now()
            );
            if (isset($_GET['username']) && !empty($_GET['username']))
                $data['username'] = $_GET['username'];

            if (isset($_GET['password']) && !empty($_GET['password']))
                $data['password'] = Helpers::Hash($_GET['password']);

            if (isset($_GET['user_access_level_id']) && !empty($_GET['user_access_level_id']))
                $data['user_access_level_id'] = $_GET['user_access_level_id'];

            if (isset($_GET['is_active']) && !empty($_GET['is_active']) && is_numeric($_GET['is_active']))
                $data['is_active'] = $_GET['is_active'];
            else
                $data['is_active'] = 0;

            if (isset($_GET['role']) && !empty($_GET['role']) && is_numeric($_GET['role']))
                $data['role'] = $_GET['role'];
            elseif ($_GET['type_of_access'] == 'Administrator')
                $data['role'] = 1;
            else
                $data['role'] = 2;

            if (isset($_GET['employee_id']) && !empty($_GET['employee_id']))
                $data['employee_id'] = $_GET['employee_id'];

            if (isset($_GET['comments']) && !empty($_GET['comments']))
                $data['comments'] = $_GET['comments'];

            $id = $this->db->insert('users', $data);
            if ($id) {
                //one card per user for now
                $this->db->where('card_id', (int) $_GET['cards']);
                if (!$this->db->update('cards', ['assigned_to' => $id]))
                    $this->error[] = 'The card was not assigned to the user';

                if (str_contains($_GET['levels'], ','))
                    $levels = explode(',', $_GET['levels']);
                else
                    $levels = [$_GET['levels']];

                foreach ($levels as $level) {
                    if (!$this->db->insert('levels', [
                        'card_id' => (int) $_GET['cards'],
                        'level_id' => $level, 'is_allowed' => 1
                    ]))
                        $this->error[] = 'The level id ' . $level . ' was not assigned to card id ' . (int) $_GET['cards'];
                }

                if (str_contains($_GET['doors'], ','))
                    $doors = explode(',', $_GET['doors']);
                else
                    $doors = [$_GET['doors']];

                foreach ($doors as $door) {
                    if (!$this->db->insert('doors', [
                        'card_id' => (int) $_GET['cards'],
                        'door_id' => $door, 'is_allowed' => 1
                    ]))
                        $this->error[] = 'The door id ' . $door . ' was not assigned to card id ' . (int) $_GET['cards'];
                }

                $this->response([
                    'success' => 'true',
                    "user_id" => $id
                ], 'json');
            } else
                $this->response(['success' => 'false'], 'json');
        } else
            $this->response([
                'success' => 'false',
                "error" => $validate
            ], 'json');
    }

    protected function validate_add_user()
    {
        if (
            !isset($_GET['first_name']) || empty($_GET['first_name'])
            || !isset($_GET['last_name']) || empty($_GET['last_name'])
            || !isset($_GET['email']) || empty($_GET['email'])
            || !isset($_GET['cards']) || empty($_GET['cards'])
            || !isset($_GET['doors']) || empty($_GET['doors'])
            || !isset($_GET['levels']) || empty($_GET['levels'])
            || !isset($_GET['type_of_access']) || empty($_GET['type_of_access'])
        ) {
            return 'Invalid Parameters';
        }

        if (!filter_var($_GET['email'], FILTER_VALIDATE_EMAIL)) {
            return 'Invalid email';
        }

        $this->db->where('email', $_GET['email']);
        if ($this->db->getOne('users'))
            return 'User already exists';

        return true;
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
        if (isset($_GET['user_id']) && !empty($_GET['user_id']) && is_numeric($_GET['user_id'])) {
            $this->db->where('user_id', $this->db->escape($_GET['user_id']));
            if ($this->db->delete('users'))
                $this->response(['success' => 'true'], 'json');
            else
                $this->response(['success' => 'false'], 'json');
        }
    }
}
