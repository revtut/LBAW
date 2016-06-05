<?php

function has_to_pay($id)
{
    global $conn;
    $stmt = $conn->prepare("select last_donative, periodicity, frozen from friends where id = ?");
    $stmt->execute(array($id));

    $result = $stmt->fetchAll();

    $last_donative = $result[0]["last_donative"];
    $periodicity = $result[0]["periodicity"];
    $frozen = $result[0]["frozen"];


    if(!$frozen){
        $currentDate = new DateTime();
        $last_donative = new DateTime($last_donative);
        $diff = $last_donative->diff($currentDate);
        $diff=$diff->format("%R%a");

        if($periodicity === 'Mensal' && $diff >= 30 ){
            return true;
        }
        else if($periodicity === 'Trimestral' && $diff >= 90){
            return true;
        }
        else if($periodicity === 'Semestral' && $diff >= 180){
            return true;
        }
        else if($periodicity === 'Anual' && $diff >= 365){
            return true;
        }
    }

    return false;

}


function how_many_month_to_pay($id)
{
    global $conn;
    $stmt = $conn->prepare("select last_donative, periodicity, frozen from friends where id = ?");
    $stmt->execute(array($id));

    $result = $stmt->fetchAll();

    $last_donative = $result[0]["last_donative"];
    $periodicity = $result[0]["periodicity"];
    $frozen = $result[0]["frozen"];


    if(!$frozen){
        $currentDate = new DateTime();
        $last_donative = new DateTime($last_donative);
        $diff = $last_donative->diff($currentDate);
        $diff=$diff->format("%R%a");

        if($periodicity === 'Mensal' && $diff >= 30 ){
            return floor($diff/30);
        }
        else if($periodicity === 'Trimestral' && $diff >= 90){
            return floor($diff/90);
        }
        else if($periodicity === 'Semestral' && $diff >= 180){
            return floor($diff/180);
        }
        else if($periodicity === 'Anual' && $diff >= 365){
            return floor($diff/365);
        }
    }

    return 0;
}