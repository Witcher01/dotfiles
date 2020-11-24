/* See LICENSE file for copyright and license details. */

/* for XF86 Media Keys */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "xos4 Terminus:size=12" };
static const char dmenufont[]       = "Anonymous Pro:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "grey5";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                instance        title       tags mask     isfloating   monitor */
	/*{ "Gimp",             NULL,           NULL,       0,            1,           -1 }, */
	{ "Firefox",            NULL,           NULL,       1 << 1,       0,           -1 },
	{ "Tor Browser",        "Navigator",    NULL,       0,            1,           -1 },
	{ "jetbrains-idea-ce",  NULL,           NULL,       1 << 2,       0,           -1 },
	{ "Atom",               NULL,           NULL,       1 << 2,       0,           -1 },
	{ "Spotify",            NULL,           NULL,       1 << 3,       0,           -1 },
	{ "Thunderbird",        NULL,           NULL,       1 << 4,       0,           -1 },
	{ "discord",            NULL,           NULL,       1 << 6,       0,           -1 },
	{ "Veracrypt",          NULL,           NULL,       1 << 7,       1,           -1 },
	{ "keepassxc",          NULL,           NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "[D]",      deck },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/usr/bin/zsh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

/* custom commands */
static const char *dmenubar[] = { "dmenubar", NULL };
static const char *lockscreen[] = { "slock", NULL };
static const char *spotifypause[] = { "dbus-send", "--print-reply", "--dest=org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2", "org.mpris.MediaPlayer2.Player.PlayPause", NULL };
static const char *spotifytruepause[] = { "dbus-send", "--print-reply", "--dest=org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2", "org.mpris.MediaPlayer2.Player.Pause", NULL };
static const char *spotifynext[] = { "dbus-send", "--print-reply", "--dest=org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2", "org.mpris.MediaPlayer2.Player.Next", NULL };
static const char *spotifyprev[] = { "dbus-send", "--print-reply", "--dest=org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2", "org.mpris.MediaPlayer2.Player.Previous", NULL };
/* static const char *cmuspause[] = { "cmus-remote", "-u", NULL }; */
/* static const char *cmustruepause[] = { "cmus-remote", "-s", NULL }; */
/* static const char *cmusnext[] = { "cmus-remote", "-n", NULL }; */
/* static const char *cmusprev[] = { "cmus-remote", "-r", NULL }; */
/* static const char *cmusaudiodown[] = { "cmus-remote", "-v", "-1%", NULL }; */
/* static const char *cmusaudioup[] = { "cmus-remote", "-v", "+1%", NULL }; */
static const char *brightup[] = { "brightnessctl", "set", "+10%", NULL };
static const char *brightdown[] = { "brightnessctl", "set", "10%-", NULL };
static const char *mutetoggle[] = { "pactl", "set-sink-mute", "0", "toggle", NULL };
static const char *audioup[] = { "pactl", "set-sink-volume", "0", "+5%", NULL };
static const char *audiodown[] = { "pactl", "set-sink-volume", "0", "-5%", NULL };


static Key keys[] = {
	/* modifier                     key        function        argument */
	/* { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } }, */
	/* { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } }, */
	{ MODKEY|ShiftMask,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	/* { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } }, */
	/* { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } }, */
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	/* { MODKEY,                       XK_Return, zoom,           {0} }, */
	{ MODKEY,                       XK_Tab,    view,           {0} },
	/* { MODKEY|ShiftMask,             XK_c,      killclient,     {0} }, */
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0  } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_c,      quit,           {0} },

	/* Custom shortcuts */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = lockscreen } },
    /* replace toggle bar with dmenubar */
	{ MODKEY,                       XK_b,      spawn,       {.v = dmenubar } },
	/* XF86 keys */
	/* configuration for spotify */
	{ 0,                            XF86XK_AudioPlay,        spawn, {.v = spotifypause } },
	{ 0,                            XF86XK_AudioStop,        spawn, {.v = spotifytruepause } },
	{ 0,                            XF86XK_AudioPrev,        spawn, {.v = spotifyprev } },
	{ 0,                            XF86XK_AudioNext,        spawn, {.v = spotifynext } },
    /* configuration for cmus */
	/* { 0,                            XF86XK_AudioPlay,        spawn, {.v = cmuspause } }, */
	/* { 0,                            XF86XK_AudioStop,        spawn, {.v = cmustruepause } }, */
	/* { 0,                            XF86XK_AudioPrev,        spawn, {.v = cmusprev } }, */
	/* { 0,                            XF86XK_AudioNext,        spawn, {.v = cmusnext } }, */
	/* { 0,                            XF86XK_AudioRaiseVolume, spawn, {.v = cmusaudioup } }, */
	/* { 0,                            XF86XK_AudioLowerVolume, spawn, {.v = cmusaudiodown } }, */

	{ 0,                            XF86XK_MonBrightnessUp,     spawn, {.v = brightup } },
	{ 0,                            XF86XK_MonBrightnessDown,   spawn, {.v = brightdown } },
	{ 0,                            XF86XK_AudioMute,           spawn, {.v = mutetoggle } },
	{ 0,                            XF86XK_AudioRaiseVolume,    spawn, {.v = audioup } },
	{ 0,                            XF86XK_AudioLowerVolume,    spawn, {.v = audiodown } },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

