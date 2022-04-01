<?php

/**
 * Helper class to provide common functionalities like
 * encryption, decryption, hashing, etc...
 */
class Helpers
{
    const ALGORITHM = PASSWORD_BCRYPT;

    const CIPHER = 'aes-256-ctr';
    const DIGEST = 'sha256';

    /**
     * Hash function with automatic cost calculation
     */
    public static function Hash($string)
    {
        $timeTarget = 0.05; // 50 milliseconds
        $cost = 8;
        do {
            $cost++;
            $start = microtime(true);
            password_hash($string, self::ALGORITHM, ["cost" => $cost]);
            $end = microtime(true);
        } while (($end - $start) < $timeTarget);
        return password_hash($string, self::ALGORITHM, ["cost" => $cost]);
    }

    /**
     * 
     *
     * @param	string	$key
     * @param	string	$value
     * 
     * @return	string
     */
    public static function encrypt(string $key, string $value): string
    {
        $key       = openssl_digest($key, self::DIGEST, true);
        $iv_length = openssl_cipher_iv_length(self::CIPHER);
        $iv        = openssl_random_pseudo_bytes($iv_length);

        return base64_encode($iv . openssl_encrypt($value, self::CIPHER, $key, OPENSSL_RAW_DATA, $iv));
    }

    /**
     * 
     *
     * @param	string	$key
     * @param	string	$value
     * 
     * @return	string
     */
    public static function decrypt(string $key, string $value): string
    {
        $result    = '';

        $key       = openssl_digest($key, self::DIGEST, true);
        $iv_length = openssl_cipher_iv_length(self::CIPHER);
        $value     = base64_decode($value);
        $iv        = substr($value, 0, $iv_length);
        $value     = substr($value, $iv_length);

        if (strlen($iv) == $iv_length) {
            $result = openssl_decrypt($value, self::CIPHER, $key, OPENSSL_RAW_DATA, $iv);
        }

        return $result;
    }

    public static function token($bytes = 64)
    {
        $rand_token = openssl_random_pseudo_bytes($bytes);
        //change binary to hexadecimal
        return bin2hex($rand_token);
    }
}

/**
 * Helper class to dump all the request to a text file
 */
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