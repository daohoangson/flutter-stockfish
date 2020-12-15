#include "../Stockfish/src/bitboard.h"
#include "../Stockfish/src/endgame.h"
#include "../Stockfish/src/position.h"
#include "../Stockfish/src/search.h"
#include "../Stockfish/src/tt.h"
#include "../Stockfish/src/uci.h"
#include "../Stockfish/src/syzygy/tbprobe.h"

#include "flutter_stockfish.h"

namespace PSQT {
  void init();
}

void stockfish_init(void) {
	UCI::init(Options);
	Tune::init();
	PSQT::init();
	Bitboards::init();
	Position::init();
	Bitbases::init();
	Endgames::init();
	Eval::NNUE::init();
}
