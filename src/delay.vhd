-- For oppgave a)

library ieee;
use ieee.std_logic_1164.all;

entity delay is 
    port (
        -- System Clock and Reset
        rst_n        : in  std_ulogic;
        mclk         : in  std_ulogic;
        indata       : in  std_ulogic_vector(7 downto 0);
        outdata      : out std_ulogic_vector(7 downto 0)
    );  
end delay;

architecture rtl of delay is 
    signal a, b, c : std_ulogic_vector(7 downto 0);
begin  
    process (rst_n, mclk) is    
        variable v1, v2 : std_ulogic_vector(7 downto 0);
    begin
        if (rst_n = '0') then       
            a <= (others => '0');
            v1 := (others => '0');
            b <= (others => '0');
            v2 := (others => '0');
            c <= (others => '0');
        elsif rising_edge(mclk) then
            -- This is a "register process" with sequential "registers"
            -- that only change every rising edge, meaning that each
            -- "register" only "sees" the value of the preceding "register"
            -- from the previous clock cycle. In practical terms, this means
            -- that the value in 'indata' traverses each "register" every
            -- clock cycle.
            
            -- map 'a' to 'indata', reflecting an instantaneous change
            a  <= indata;

            -- store last value (not current value) of 'a' to 'v1'
            v1 := A;

            -- map 'b' to value of 'v1'
            b  <= v1;

            -- store last value (not current value) of 'b' to 'v2'
            v2 := B;

            -- map 'c' to value of 'v2'
            c  <= v2;
        end if;
    end process;

    -- map 'outdata' to 'c', reflecting an instantaneous change
    outdata  <= c;
end rtl;
