// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";

import "forge-std/Vm.sol";

import "../Sudoku.sol";

contract ContractTest is DSTest {
	Sudoku s;
    Vm vm = Vm(HEVM_ADDRESS);

    function setUp() public {
		s = new Sudoku();
	}

	function testSolution() public {
		uint8[81] memory sol = [
			1, 2, 3, 4, 5, 6, 7, 8, 9,
			4, 5, 6, 7, 8, 9, 1, 2, 3,
			7, 8, 9, 1, 2, 3, 4, 5, 6,
			2, 3, 4, 5, 6, 7, 8, 9, 1,
			5, 6, 7, 8, 9, 1, 2, 3, 4,
			8, 9, 1, 2, 3, 4, 5, 6, 7,
			3, 4, 5, 6, 7, 8, 9, 1, 2,
			6, 7, 8, 9, 1, 2, 3, 4, 5,
			9, 1, 2, 3, 4, 5, 6, 7, 8
		];
		s.initBoard(sol);
		assertTrue(s.check());
	}

	function testFuzz_Solution(uint8[81] memory sol) public {
		for (uint8 i = 0; i < 81; ++i)
			//vm.assume(sol[i] < 9);
			sol[i] = sol[i] % 9 + 1;

		s.initBoard(sol);
		assertTrue(!s.check());
	}
}
