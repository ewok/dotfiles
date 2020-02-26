#include QMK_KEYBOARD_H

#define _DEF 0
#define _SPC 1
#define _TAB 2

#define TABDUAL   LT(_TAB, KC_TAB)
#define CAPSDUAL  CTL_T(KC_ESC)
#define SPACEDUAL LT(_SPC, KC_SPACE)
#define ENTERDUAL CTL_T(KC_ENT)

#define ARRLEFT  ALT_T(KC_LEFT)
#define ARRDOWN  GUI_T(KC_DOWN)
#define ARRUP    SFT_T(KC_UP)
#define ARRRIGHT CTL_T(KC_RIGHT)

#define KC_COPY LCTL(KC_INS)
#define KC_CUT LSFT(KC_DEL)
#define KC_PASTE LSFT(KC_INS)
/*
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    [_DEF] = LAYOUT_60_ansi(
        KC_GRV,   KC_1,    KC_2,    KC_3,    KC_4,     KC_5,     KC_6,         KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_BSPC,   \
        TABDUAL,  KC_Q,    KC_W,    KC_E,    KC_R,     KC_T,     KC_Y,         KC_U,    KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSLS,   \
        CAPSDUAL, KC_A,    KC_S,    KC_D,    KC_F,     KC_G,     KC_H,         KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,          ENTERDUAL, \
        KC_LSFT,  KC_Z,    KC_X,    KC_C,    KC_V,     KC_B,     KC_N,         KC_M,    KC_COMM, KC_DOT,  KC_SLSH, ARRUP,                       \
        KC_LCTL,  KC_LGUI, KC_LALT,                            SPACEDUAL,                        KC_RALT, ARRLEFT, ARRDOWN, ARRRIGHT),

    [_SPC] = LAYOUT_60_ansi(
        KC_PSCR,  KC_F1,   KC_F2,   KC_F3,   KC_F4,    KC_F5,    KC_F6,        KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_DEL,    \
        _______,  KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_U,  _______,  _______,      _______, _______, _______, _______, KC_ESC,  _______,  _______,  \
        _______,  KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_D,  _______,  KC_LEFT,      KC_DOWN, KC_UP,   KC_RGHT, _______, _______,          KC_MPLY,   \
        _______,  _______, KC_CUT,  KC_COPY, KC_PASTE, KC_SPACE, LGUI(KC_SPC), KC_ENT,  KC_BTN1, KC_BTN2, KC_VOLU, _______,                     \
        _______,  _______, _______,                             _______,                         KC_MPRV, KC_VOLD, KC_MNXT, _______ ),

    [_TAB] = LAYOUT_60_ansi(
        KC_WAKE,  _______, _______, _______, _______,  _______,  _______,      _______, _______, _______, _______, _______, _______, KC_INS,    \
        _______,  DM_PLY1, _______, _______, _______,  _______,  _______,      _______, _______, _______, _______, KC_ESC,  _______, _______,   \
        _______,  DM_REC1, DM_RSTP, _______, _______,  _______,  KC_HOME,      KC_PGDN, KC_PGUP, KC_END,  _______, _______,          KC_ENT,    \
        _______,  _______, _______, _______, _______,  _______,  _______,      KC_ENT,  _______, _______, _______, _______,                     \
        _______,  _______, _______,                              _______,                        _______, _______, _______, _______),
};
*/

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* 0: plain Qwerty without layer switching
     *         ,---------------. ,---------------. ,---------------.
     *         |F13|F14|F15|F16| |F17|F18|F19|F20| |F21|F22|F23|F24|
     * ,---.   |---------------| |---------------| |---------------| ,-----------. ,---------------. ,-------.
     * |Esc|   |F1 |F2 |F3 |F4 | |F5 |F6 |F7 |F8 | |F9 |F10|F11|F12| |PrS|ScL|Pau| |VDn|VUp|Mut|Pwr| | Help  |
     * `---'   `---------------' `---------------' `---------------' `-----------' `---------------' `-------'
     * ,-----------------------------------------------------------. ,-----------. ,---------------. ,-------.
     * |  `|  1|  2|  3|  4|  5|  6|  7|  8|  9|  0|  -|  =|JPY|Bsp| |Ins|Hom|PgU| |NmL|  /|  *|  -| |Stp|Agn|
     * |-----------------------------------------------------------| |-----------| |---------------| |-------|
     * |Tab  |  Q|  W|  E|  R|  T|  Y|  U|  I|  O|  P|  [|  ]|  \  | |Del|End|PgD| |  7|  8|  9|  +| |Mnu|Und|
     * |-----------------------------------------------------------| `-----------' |---------------| |-------|
     * |CapsL |  A|  S|  D|  F|  G|  H|  J|  K|  L|  ;|  :|  #|Retn|               |  4|  5|  6|KP,| |Sel|Cpy|
     * |-----------------------------------------------------------|     ,---.     |---------------| |-------|
     * |Shft|  <|  Z|  X|  C|  V|  B|  N|  M|  ,|  ,|  /| RO|Shift |     |Up |     |  1|  2|  3|KP=| |Exe|Pst|
     * |-----------------------------------------------------------| ,-----------. |---------------| |-------|
     * |Ctl|Gui|Alt|MHEN|HNJ| Space  |H/E|HENK|KANA|Alt|Gui|App|Ctl| |Lef|Dow|Rig| |  0    |  .|Ent| |Fnd|Cut|
     * `-----------------------------------------------------------' `-----------' `---------------' `-------'
     */
    [_DEF] = LAYOUT_all(
                      KC_F13,  KC_F14,  KC_F15,   KC_F16,   KC_F17,   KC_F18,         KC_F19,  KC_F20,  KC_F21,  KC_F22,  KC_F23,  KC_F24,
    KC_ESC,           KC_F1,   KC_F2,   KC_F3,    KC_F4,    KC_F5,    KC_F6,          KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,               KC_PSCR, KC_SLCK, KC_PAUS,    KC_VOLD, KC_VOLU, KC_MUTE, KC_PWR,     KC_HELP,
    KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,     KC_5,     KC_6,     KC_7,           KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_JYEN, KC_BSPC,     KC_INS,  KC_HOME, KC_PGUP,    KC_NLCK, KC_PSLS, KC_PAST, KC_PMNS,    KC_STOP, KC_AGIN,
    TABDUAL, KC_Q,    KC_W,    KC_E,    KC_R,     KC_T,     KC_Y,     KC_U,           KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC,          KC_BSLS,     KC_DEL,  KC_END,  KC_PGDN,    KC_P7,   KC_P8,   KC_P9,   KC_PPLS,    KC_MENU, KC_UNDO,
    CAPSDUAL,KC_A,    KC_S,    KC_D,    KC_F,     KC_G,     KC_H,     KC_J,           KC_K,    KC_L,    KC_SCLN, KC_QUOT,          KC_NUHS, ENTERDUAL,                                 KC_P4,   KC_P5,   KC_P6,   KC_PCMM,    KC_SLCT, KC_COPY,
    KC_LSFT, KC_NUBS, KC_Z,    KC_X,    KC_C,     KC_V,     KC_B,     KC_N,           KC_M,    KC_COMM, KC_DOT,  KC_SLSH,          KC_RO,   KC_RSFT,              KC_UP,               KC_P1,   KC_P2,   KC_P3,   KC_PEQL,    KC_EXEC, KC_PSTE,
    KC_LCTL, KC_LGUI, KC_LALT, KC_MHEN, KC_HANJ,         SPACEDUAL,   KC_HAEN,        KC_HENK, KC_KANA, KC_RALT, KC_RGUI, KC_APP,  KC_RCTL,              KC_LEFT, KC_DOWN, KC_RGHT,    KC_P0,            KC_PDOT, KC_PENT,    KC_FIND, KC_CUT
    ),
    [_SPC] = LAYOUT_all(
                      ______,  ______,  ______,   ______,   ______,   ______,         ______,  ______,  ______,  ______,  ______,  ______,
    KC_PSCR,          ______,  ______,  ______,   ______,   ______,   ______,         ______,  ______,  ______,  ______,  ______,  ______,             ______,______,______,    ______,______,______,______,    ______,
    KC_PSCR, KC_F1,   KC_F2,   KC_F3,   KC_F4,    KC_F5,    KC_F6,    KC_F7,          KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  ______, KC_DEL,     ______,______,______,    ______,______,______,______,    ______,______,
    ______,  KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_U,  ______,   ______,   ______,         ______,  ______,  ______,  KC_ESC,  ______,          ______,     ______,______,______,    ______,______,______,______,    ______,______,
    ______,  KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_D,  ______,   KC_LEFT,  KC_DOWN,        KC_UP,   KC_RGHT, ______,  ______,           ______, KC_MPLY,                             ______,______,______,______,    ______,______,
    ______,  ______,  ______,  KC_CUT,  KC_COPY,  KC_PASTE, KC_SPACE, LGUI(KC_SPACE), KC_ENT,  KC_BTN1, KC_BTN2, KC_VOLU,          ______,  ______,           ______,           ______,______,______,______,    ______,______,
    ______,  ______,  ______,  ______,  ______,             ______,   ______,         ______,  ______,  KC_MPRV, ______,  KC_VOLD, KC_MNXT,            ______,______,______,    ______,       ______,______,    ______,______
    ),
    [_TAB] = LAYOUT_all(
                      ______,  ______,  ______,   ______,   ______,   ______,         ______,  ______,  ______,  ______,  ______,  ______,
    ______,           ______,  ______,  ______,   ______,   ______,   ______,         ______,  ______,  ______,  ______,  ______,  ______,             ______,______,______,    ______,______,______,______,    ______,
    ______,  ______,  ______,  ______,  ______,   ______,   ______,   ______,         ______,  ______,  ______,  ______,  ______,  ______, ______,     ______,______,______,    ______,______,______,______,    ______,______,
    ______,  DM_PLY1, ______,  ______,  ______,   ______,   ______,   ______,         ______,  ______,  ______,  ______,  ______,          ______,     ______,______,______,    ______,______,______,______,    ______,______,
    ______,  DM_REC1, DM_RSTP, ______,  ______,   ______,   KC_HOME,  KC_PGDN,        KC_PGUP, KC_END,  ______,  ______,           ______, ______,                              ______,______,______,______,    ______,______,
    ______,  ______,  ______,  ______,  ______,   ______,   ______,   ______,         KC_ENT,  ______,  ______,  ______,           ______, ______,            ______,           ______,______,______,______,    ______,______,
    ______,  ______,  ______,  ______,  ______,             ______,   ______,         ______,  ______,  ______,  ______,  ______, ______,              ______,______,______,    ______,       ______,______,    ______,______
    ),
};
