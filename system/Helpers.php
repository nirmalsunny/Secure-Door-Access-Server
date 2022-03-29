<?php

class Helpers
{
    const ALGORITHM = PASSWORD_BCRYPT;
    
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
}
