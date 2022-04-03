// SPDX-License-Identifier: GPL-v3
pragma solidity >=0.8.10;

contract Sudoku {
	uint8[81] board;

	function initBoard(uint8[81] memory b) public {
		board = b;
	}

	function set(uint8 p, uint8 v) public {
		require(v >= 1 && v <= 9);
		board[p] = v;
	}

	function check() public view returns (bool) {
		return
			checkAllRow()
			&& checkAllCol()
			&& checkAllQ()
		;
	}

	function checkAllRow() internal view returns (bool) {
		for (uint8 i = 0; i < 9; ++i)
			if (!checkRow(i))
				return false;
		return true;
	}

	function checkRow(uint8 row) internal view returns (bool) {
		require(row >= 0 && row < 9);
		uint8[9] memory counts;

		uint8 init = row * 9;
		for (uint8 i = init; i < init + 9; ++i)
			++counts[board[i] - 1];

		return checkCounts(counts);
	}

	function checkAllCol() internal view returns (bool) {
		for (uint8 i = 0; i < 9; ++i)
			if (!checkCol(i))
				return false;
		return true;
	}

	function checkCol(uint8 col) internal view returns (bool) {
		require(col >= 0 && col < 9);
		uint8[9] memory counts;

		for (uint8 i = 0; i < 81; i += 9)
			++counts[board[i] - 1];

		return checkCounts(counts);
	}

	function checkAllQ() internal view returns (bool) {
		for (uint8 i = 0; i < 9; ++i)
			if (!checkQ(i))
				return false;
		return true;
	}

	function checkQ(uint8 q) internal view returns (bool) {
		require(q >= 0 && q < 9);
		uint8[9] memory counts;

		uint8 x = (q % 3) * 3;
		uint8 y = q / 3;

		for (uint8 i = x; i < x + 3; ++i)
			for (uint8 j = y; j < y + 3; ++j)
				++counts[board[i * 9 + j] - 1];

		return checkCounts(counts);
	}

	function checkCounts(uint8[9] memory counts) internal pure returns (bool) {
		for (uint8 i = 0; i < 9; ++i)
			if (counts[i] != 1)
				return false;
		return true;
	}
}
