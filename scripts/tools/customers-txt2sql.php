#!/usr/bin/php
<?php

/*
  customers-txt2sql.php - prepare customer SQL creation script from OTRS
  customer data in TXT file (tab delimitered, UTF-8)

  Copyright (C) 2012 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2, or (at your option)
  any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  02111-1307, USA.
*/


/*
    PLEASE NOTE: this script is quite old and may be incompatible with
    newer OTRS database schema. Use with care and test well before using.
*/


/* data length limits */
$COL_MAX_LEN = array (
     0  => 150,
     1  => 100,
     2  => 100,
     3  => 150,
     4  => 150,
     5  => 150,
     6  => 150,
     7  => 200,
     8  => 200,
     9  => 200,
    10  => 250
);


/* abort program execution and exit */
function abort($msg) {
    fwrite(STDERR, "ERROR: $msg\n");
    exit(1);
};


if (($handle = fopen('php://stdin', 'r')) !== FALSE)
{
    $row = 0;
    $emails = array();

    // customer user SQL insert command
    $sql_cu = 'INSERT INTO customer_user (login,email,customer_id,pw,title,first_name,last_name,phone,fax,mobile,street,zip,city,country,comments,valid_id,create_time,create_by,change_time,change_by) VALUES ';

    // customer preferences SQL insert command
    $sql_cp = 'INSERT INTO customer_preferences VALUES ';

    /* process every live from CSV file */
    while (($data = fgetcsv($handle, 0, "\t")) !== FALSE)
    {
        $row++;
        $num = count($data);

        /* 11 cols required */
        if ($num != 11)
            abort("Wrong numer of cols in row " . $row . ": " . $num);

        /* valid e-mail required in first col */
        if ( !filter_var($data[0], FILTER_VALIDATE_EMAIL) )
            abort("Invalid e-mail address in row $row: " . $data[0]);

        /* e-mails must be unique */
        if ( array_key_exists($data[0], $emails) )
            abort("Duplicate e-mail address found in row $row: " . $data[0] . " (first occurence in row " . $emails[$data[0]] . ")");

        /* first and last name must not be empty */
        if (strlen($data[1]) == 0)
            abort("Empty first name specified in row $row col 2");
        if (strlen($data[2]) == 0)
            abort("Empty last name specified in row $row col 3");

        /* save e-mail as seen */
        $emails[$data[0]] = $row;

        /* check for max data lengths */
        for ($col=0; $col < 11; $col++)
        {
            if (strlen($data[$col]) > $COL_MAX_LEN[$col])
                abort("Variable in col " . ($col + 1) . ", rom $row longer than max. allowed $COL_MAX_LEN[$col] chars!");
        };

        // add customer record
        $sql_cu .= "(" .
            "'" . mysql_escape_string($data[0]) . "'," .      // email       -> login
            "'" . mysql_escape_string($data[0]) . "'," .      // email       -> email
            "'" . mysql_escape_string($data[0]) . "'," .      // email       -> customer_id
            "NULL," .                                         // NULL        -> pw
            "''," .                                           // ''          -> title
            "'" . mysql_escape_string($data[1]) . "'," .      // first name  -> first_name
            "'" . mysql_escape_string($data[2]) . "'," .      // surname     -> last_name
            "'" . mysql_escape_string($data[3]) . "'," .      // phone       -> phone
            "'" . mysql_escape_string($data[4]) . "'," .      // fax         -> fax
            "'" . mysql_escape_string($data[5]) . "'," .      // mobile      -> mobile
            "'" . mysql_escape_string($data[6]) . "'," .      // street      -> street
            "'" . mysql_escape_string($data[7]) . "'," .      // zip         -> zip
            "'" . mysql_escape_string($data[8]) . "'," .      // city        -> city
            "'" . mysql_escape_string($data[9]) . "'," .      // country     -> country
            "'" . mysql_escape_string($data[10]) . "'," .     // comments    -> comments
            "1,now(),1,now(),1),";                            // valid_id,create_time,create_by,change_time,change_by

        // add customer preferences
        $sql_cp .=
            "('" . mysql_escape_string($data[0]) . "','UserShowTickets','25')," .
            "('" . mysql_escape_string($data[0]) . "','UserLanguage','pl')," .
            "('" . mysql_escape_string($data[0]) . "','UserTheme','Standard')," .
            "('" . mysql_escape_string($data[0]) . "','UserRefreshTime',''),";

    };

    fclose($handle);

    // replace last comma with semicolon and print final SQL statements
    $sql_cu = substr_replace($sql_cu, ";", -1);
    $sql_cp = substr_replace($sql_cp, ";", -1);
    echo("$sql_cu\n");
    echo("$sql_cp\n");


    // successfull abort
    exit(0);
}
else
{
    abort('Cannot read from STDIN!');
};

?>
