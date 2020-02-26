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
