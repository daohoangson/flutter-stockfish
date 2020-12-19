#ifdef __cplusplus
extern "C" {
#endif

void stockfish_init(void);

char * stockfish_trace_eval();

char * stockfish_uci(char *);

#ifdef __cplusplus
}
#endif
