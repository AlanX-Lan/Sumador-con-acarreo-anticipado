library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sumador is
    Port ( a, b : in  unsigned(3 downto 0);
           s    : out unsigned(3 downto 0);
           c_out: out std_logic);
end sumador;

architecture Behavioral of sumador is
    signal g, p, c_in : unsigned(3 downto 0);
begin
    -- Compuertas XOR para generar los bits de acarreo anticipado
    g <= a and b;
    p <= a xor b;

    -- Compuertas AND para generar el acarreo anticipado
    c_in(0) <= '0'; -- Acarreo de entrada inicializado en 0
    c_in(1) <= g(0) or (p(0) and c_in(0));
    c_in(2) <= g(1) or (p(1) and c_in(1));
    c_in(3) <= g(2) or (p(2) and c_in(2));

    -- Compuertas XOR para la suma de los bits
    s <= a xor b xor c_in;

    -- Compuertas OR para generar el acarreo de salida
    c_out <= c_in(3) or (g(3) and p(3));
end Behavioral;
