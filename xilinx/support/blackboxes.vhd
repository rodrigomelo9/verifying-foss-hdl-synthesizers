library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

package VCOMPONENTS is

    attribute BOX_TYPE : string;

    component LUT2
        generic (
            INIT : bit_vector := X"0"
        );
        port (
            O  : out std_ulogic;
            I0 : in std_ulogic;
            I1 : in std_ulogic
        );
    end component;
    attribute BOX_TYPE of LUT2 : component is "PRIMITIVE";

    component FD
        generic (
            INIT : bit := '0'
        );
        port (
            Q : out std_ulogic;
            C : in std_ulogic;
            D : in std_ulogic
        );
    end component;
    attribute BOX_TYPE of FD : component is "PRIMITIVE";

end VCOMPONENTS;
