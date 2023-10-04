----------------------------------------------------------------------------------
-- Filename : display_controller.vhdl
-- Author : Antonio Alejandro Andara Lara
-- Date : 06-Nov-10-2022
-- Design Name: display controller
-- Module Name: VHDL_essentials
-- Project Name: VHDL_essentials
-- Description : In this file we will implement a design that can read two 4 bit
-- characters from a register and show it on the appropriate seven segments display
-- Additional Comments:
-- Copyright : University of Alberta, 2022
-- License : CC0 1.0 Universal
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY display_controller IS
	PORT (
		-- read in digits
		-- 0  0  0000 0000
		-- e1 e2 dig1 dig2
		
		digits : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		clock  : IN STD_LOGIC;
		-- Controls which of the seven segment displays is active
		display_select : OUT STD_LOGIC := '0';
		--controls which digit to display
		segments : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
END display_controller;

ARCHITECTURE Behavioral OF display_controller IS
	-- this signal will get the value of the character to display
	SIGNAL digit : STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN

	display_select <= clock;

	WITH clock SELECT
		digit <= digits(9) & digits(7 DOWNTO 4) WHEN '1',
		         digits(8) & digits(3 DOWNTO 0) WHEN OTHERS;
		

	-- the zybo z7 Pmod SSD: Seven Segment Display
	-- is attached to the board in such a way that
	-- the characters look upside down if we follow the
	-- mapping from the manual, for this reason we use
	-- a different mapping that solves this problem.
	WITH digit SELECT -- segments "ABCDEFG" 
		segments <= "1111110" WHEN "00000", --0
					"0000110" WHEN "00001", --1
					"1101101" WHEN "00010", --2
					"1001111" WHEN "00011", --3
					"0010111" WHEN "00100", --4
					"1011011" WHEN "00101", --5
					"1111011" WHEN "00110", --6
					"0001110" WHEN "00111", --7
					"1111111" WHEN "01000", --8
					"1011111" WHEN "01001", --9
					"0111111" WHEN "01010", --A
					"1110011" WHEN "01011", --B
					"1111000" WHEN "01100", --C
					"1100111" WHEN "01101", --D
					"1111001" WHEN "01110", --E
					"0111001" WHEN "01111", --F
					
					-- bcdHhJLPUuy
					"0000000" WHEN OTHERS;
END Behavioral;
