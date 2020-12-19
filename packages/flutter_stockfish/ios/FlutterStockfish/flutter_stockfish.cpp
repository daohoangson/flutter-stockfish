#include <iostream>
#include <sstream>

#include "../Stockfish/src/bitboard.h"
#include "../Stockfish/src/endgame.h"
#include "../Stockfish/src/position.h"
#include "../Stockfish/src/search.h"
#include "../Stockfish/src/thread.h"
#include "../Stockfish/src/tt.h"
#include "../Stockfish/src/uci.h"
#include "../Stockfish/src/syzygy/tbprobe.h"

#include "flutter_stockfish.h"

namespace PSQT {
  void init();
}

Position pos;
StateListPtr states(new std::deque<StateInfo>(1));

void stockfish_init(void) {
	UCI::init(Options);
	Tune::init();
	PSQT::init();
	Bitboards::init();
	Position::init();
	Bitbases::init();
	Endgames::init();
	
	Threads.set(size_t(Options["Threads"]));
	Search::clear();
	Eval::NNUE::init();

	pos.set("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", false, &states->back(), Threads.main());
}

char * stockfish_trace_eval() {
	StateListPtr s(new std::deque<StateInfo>(1));
	Position p;
	p.set(pos.fen(), Options["UCI_Chess960"], &s->back(), Threads.main());

	Eval::NNUE::verify();

	return strdup(Eval::trace(p).c_str());
}

char * stockfish_uci(char *command) {
	int argc = 2;
	char *argv[2] = {"", command};

	std::stringstream buffer;
	std::streambuf* backup = std::cout.rdbuf(buffer.rdbuf());
	UCI::loop(argc, argv);
	std::cout.rdbuf(backup);

	return strdup(buffer.str().c_str());
}
