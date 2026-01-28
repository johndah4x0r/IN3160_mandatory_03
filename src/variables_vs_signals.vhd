library ieee;
use ieee.std_logic_1164.all;

entity variables_vs_signals is 
    port (
        indata   : in  std_ulogic;
        outdata  : out std_ulogic_vector(7 downto 0)
    );
end variables_vs_signals;

architecture dataflow of variables_vs_signals is
    signal sig1, sig2 : std_ulogic;
begin

P_VAR_SIG_MIX:
    process (indata, sig1, sig2) is
        variable var1, var2 : std_ulogic;
    begin
        -- just to clarify things, VHDL is
        -- NOT predominantly sequential
        -- (unlike program code)
        var1 := indata;
        var2 := indata;
        sig1 <= var1;
        sig2 <= var2;

        -- map last value of var2 and var1 to outdata[0..1]
        -- outdata[0..1] = var2 << 1 | var1
        outdata(1 downto 0) <= var2 & var1;

        -- literally map outdata[2..3] = sig2 << 1 | sigi
        outdata(3 downto 2) <= sig2 & sig1;

        -- modify var2 and var1 sequentially,
        -- then modify sig2 and sig1
        var1 := not var1;
        var2 := not var2;
        sig1 <= not var1;
        sig2 <= not indata;

        -- map *new* value of var2 and var1 to outdata[4..5]
        -- outdata[4..5] = var2 << 1 | var1
        outdata(5 downto 4) <= var2 & var1;

        -- literally map outdata[6..7] = sig2 << 1 | sig1
        outdata(7 downto 6) <= sig2 & sig1;

        -- at this point, sig1 and sig2 have been changed,
        -- and outdata[2..3] and outdata[6..7] have been
        -- mapped literally to sig1 and sig2, meaning that
        -- they must acquire the same value for each "cycle"

        -- the same cannot be said for outdata[0..1] and
        -- outdata[4..5], which take on values of var1
        -- and var2, the act of which conserves the "old"
        -- values in time (unless re-assigned)
    end process;
end dataflow;
