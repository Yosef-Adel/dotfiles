/**
 * Karabiner-Elements Configuration Generator
 *
 * This file generates karabiner.json with custom keyboard remappings.
 * Run `yarn build` to regenerate the JSON config.
 *
 * Key concepts:
 * - Hyper Key: Hold spacebar to activate, tap for regular space
 * - Sublayers: Hyper + key activates a layer (e.g., Hyper + O = Open apps layer)
 */

import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, yabai, yabaiOr } from "./utils";
import { LayerCommand } from "./utils";

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

/**
 * Switches to a space by sending Right Option + number, which macOS handles
 * natively via its "Switch to Desktop N" hotkeys. Deliberately NOT yabai's
 * `space --focus`, which is slower and refuses outright while a mission-control
 * transition is still animating.
 */
const workspace = (num: string): LayerCommand => ({
  description: `Move to workspace ${num}`,
  to: [{ key_code: num as any, modifiers: ["right_option" as const] }],
});

/**
 * Sends the focused window to space N and follows it there.
 *
 * The move goes through yabai, which handles cross-space moves without the
 * scripting addition on yabai 7.x. The follow uses the same native Right
 * Option + number as above rather than yabai's `space --focus`, which can
 * refuse with "mission-control is active" when spaces are switched quickly.
 */
const moveToWorkspace = (num: string): LayerCommand => ({
  description: `Move window to workspace ${num} and follow`,
  modifiers: { mandatory: ["shift"] },
  to: [
    { shell_command: `/opt/homebrew/bin/yabai -m window --space ${num}` },
    { key_code: num as any, modifiers: ["right_option" as const] },
  ],
});

/** Hyper + Shift + N moves the window; Hyper + N just switches. Order matters. */
const space = (num: string): LayerCommand[] => [
  moveToWorkspace(num),
  workspace(num),
];

// =============================================================================
// RULES
// =============================================================================

const rules: KarabinerRules[] = [
  // ---------------------------------------------------------------------------
  // Hyper Key Setup
  // ---------------------------------------------------------------------------
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        description: "Spacebar -> Hyper Key (tap for space)",
        type: "basic",
        from: {
          key_code: "spacebar",
          modifiers: { optional: ["any"] },
        },
        to: [{ set_variable: { name: "hyper", value: 1 } }],
        to_after_key_up: [{ set_variable: { name: "hyper", value: 0 } }],
        to_if_alone: [{ key_code: "spacebar" }],
      },
    ],
  },

  // ---------------------------------------------------------------------------
  // Modifier Key Swaps
  // Purpose: Put Ctrl under thumbs (more accessible) and Cmd under pinky
  // ---------------------------------------------------------------------------
  {
    description: "Modifier key swaps",
    manipulators: [
      {
        description: "Left Option -> Right Ctrl",
        type: "basic",
        from: { key_code: "left_option", modifiers: { optional: ["any"] } },
        to: [{ key_code: "right_control" }],
      },
      {
        description: "Right Option -> Left Ctrl",
        type: "basic",
        from: { key_code: "right_option", modifiers: { optional: ["any"] } },
        to: [{ key_code: "left_control" }],
      },
      {
        description: "Left Ctrl -> Left Option",
        type: "basic",
        from: { key_code: "left_control", modifiers: { optional: ["any"] } },
        to: [{ key_code: "left_option" }],
      },
      {
        description: "Caps Lock -> Escape",
        type: "basic",
        from: { key_code: "caps_lock", modifiers: { optional: ["any"] } },
        to: [{ key_code: "escape" }],
      },
    ],
  },

  // ---------------------------------------------------------------------------
  // Hyper Key Sublayers
  // ---------------------------------------------------------------------------
  ...createHyperSubLayers({
    // Quick action
    spacebar: open(
      "raycast://extensions/stellate/mxstbr-commands/create-notion-todo"
    ),

    // -------------------------------------------------------------------------
    // Workspaces
    //   Hyper + N          -> switch to space N
    //   Hyper + Shift + N  -> send window to space N and follow it
    // -------------------------------------------------------------------------
    1: space("1"),
    2: space("2"),
    3: space("3"),
    4: space("4"),
    5: space("5"),
    6: space("6"),
    7: space("7"),
    8: space("8"),
    9: space("9"),
    0: space("0"),

    // -------------------------------------------------------------------------
    // O = Open applications
    // -------------------------------------------------------------------------
    o: {
      a: app("wezterm"),
      b: app("Obsidian"),
      d: app("Discord"),
      e: app("elmedia video player"),
      f: app("Figma"),
      // g: app("Google Chrome"),
      j: app("IntelliJ IDEA"),
      n: app("Notion"),
      r: app("OBS"),
      s: app("safari"),
      t: app("TickTick"),
      v: app("Preview"),
      c: app("Claude"),
    },

    // -------------------------------------------------------------------------
    // W = Window focus + state (yabai)
    // -------------------------------------------------------------------------
    w: {
      // Directional focus, wrapping to the opposite edge of the space
      h: yabaiOr("window --focus west", "window --focus east"),
      j: yabaiOr("window --focus south", "window --focus north"),
      k: yabaiOr("window --focus north", "window --focus south"),
      l: yabaiOr("window --focus east", "window --focus west"),

      // Display focus (kept on y/o to match the old Rectangle bindings)
      y: yabaiOr("display --focus prev", "display --focus last"),
      o: yabaiOr("display --focus next", "display --focus first"),

      // Window state
      f: yabai("window --toggle zoom-fullscreen"),
      z: yabai("window --toggle zoom-parent"),
      t: yabai("window --toggle float", "window --grid 4:4:1:1:2:2"),
      e: yabai("window --toggle split"),
      q: yabai("window --close"),

      // Space layout
      b: yabai("space --balance"),
      r: yabai("space --rotate 270"),
      g: yabai("space --toggle padding", "space --toggle gap"),

      semicolon: {
        description: "Hide Window",
        to: [{ key_code: "h", modifiers: ["right_command"] }],
      },
    },

    // -------------------------------------------------------------------------
    // M = Move windows around the tree
    // -------------------------------------------------------------------------
    m: {
      // Warp moves the window within the bsp tree; swap trades it with its
      // neighbour, which is the sensible fallback when there's nowhere to warp.
      h: yabaiOr("window --warp west", "window --swap west"),
      j: yabaiOr("window --warp south", "window --swap south"),
      k: yabaiOr("window --warp north", "window --swap north"),
      l: yabaiOr("window --warp east", "window --swap east"),

      // Send window to another display (no-op on a single-display setup)
      y: yabaiOr("window --display prev", "window --display last"),
      o: yabaiOr("window --display next", "window --display first"),

      // Mirror the tree
      f: yabai("space --mirror y-axis"),
      d: yabai("space --mirror x-axis"),
    },

    // -------------------------------------------------------------------------
    // R = Resize the focused window
    // -------------------------------------------------------------------------
    r: {
      h: yabaiOr("window --resize right:-40:0", "window --resize left:-40:0"),
      l: yabaiOr("window --resize right:40:0", "window --resize left:40:0"),
      j: yabaiOr("window --resize bottom:0:40", "window --resize top:0:40"),
      k: yabaiOr("window --resize bottom:0:-40", "window --resize top:0:-40"),
      0: yabai("space --balance"),
    },

    // -------------------------------------------------------------------------
    // S = System controls (volume, brightness, lock, media)
    // -------------------------------------------------------------------------
    s: {
      u: { to: [{ key_code: "volume_increment" }] },
      j: { to: [{ key_code: "volume_decrement" }] },
      i: { to: [{ key_code: "display_brightness_increment" }] },
      k: { to: [{ key_code: "display_brightness_decrement" }] },
      p: { to: [{ key_code: "play_or_pause" }] },
      semicolon: { to: [{ key_code: "fastforward" }] },
      l: {
        description: "Lock Screen",
        to: [{ key_code: "q", modifiers: ["right_control", "right_command"] }],
      },
    },

    // -------------------------------------------------------------------------
    // V = Vim-style movement (hjkl -> arrow keys)
    // -------------------------------------------------------------------------
    v: {
      h: { to: [{ key_code: "left_arrow" }] },
      j: { to: [{ key_code: "down_arrow" }] },
      k: { to: [{ key_code: "up_arrow" }] },
      l: { to: [{ key_code: "right_arrow" }] },
    },

    // -------------------------------------------------------------------------
    // C = Music controls
    // -------------------------------------------------------------------------
    c: {
      p: { to: [{ key_code: "play_or_pause" }] },
      n: { to: [{ key_code: "fastforward" }] },
      b: { to: [{ key_code: "rewind" }] },
    },
  }),
];

// =============================================================================
// GENERATE CONFIG
// =============================================================================

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: { show_in_menu_bar: true },
      profiles: [
        {
          name: "Default",
          // Karabiner activates the profile flagged as selected; without this
          // it falls back to whatever it decides is default, which is not
          // necessarily this one.
          selected: true,
          complex_modifications: { rules },
        },
      ],
    },
    null,
    2
  )
);
