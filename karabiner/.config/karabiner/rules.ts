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
import { createHyperSubLayers, app, open, rectangle } from "./utils";

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

/** Creates a workspace switch command (sends Right Option + number) */
const workspace = (num: string) => ({
  description: `Move to workspace ${num}`,
  to: [{ key_code: num as any, modifiers: ["right_option" as const] }],
});

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
        description: "Left Cmd -> Left Ctrl",
        type: "basic",
        from: { key_code: "left_command", modifiers: { optional: ["any"] } },
        to: [{ key_code: "left_control" }],
      },
      {
        description: "Right Cmd -> Right Ctrl",
        type: "basic",
        from: { key_code: "right_command", modifiers: { optional: ["any"] } },
        to: [{ key_code: "right_control" }],
      },
      {
        description: "Left Ctrl -> Left Cmd",
        type: "basic",
        from: { key_code: "left_control", modifiers: { optional: ["any"] } },
        to: [{ key_code: "left_command" }],
      },
      {
        description: "Right Option -> Right Cmd",
        type: "basic",
        from: { key_code: "right_option", modifiers: { optional: ["any"] } },
        to: [{ key_code: "right_command" }],
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
    // Workspace switching (Hyper + 0-9)
    // -------------------------------------------------------------------------
    1: workspace("1"),
    2: workspace("2"),
    3: workspace("3"),
    4: workspace("4"),
    5: workspace("5"),
    6: workspace("6"),
    7: workspace("7"),
    8: workspace("8"),
    9: workspace("9"),
    0: workspace("0"),

    // -------------------------------------------------------------------------
    // O = Open applications
    // -------------------------------------------------------------------------
    o: {
      a: app("wezterm"),
      b: app("Obsidian"),
      c: app("Visual Studio Code"),
      d: app("Discord"),
      e: app("elmedia video player"),
      f: app("Figma"),
      g: app("Google Chrome"),
      j: app("IntelliJ IDEA"),
      n: app("Notion"),
      r: app("OBS"),
      s: app("safari"),
      t: app("TickTick"),
      v: app("Preview"),
      z: app("zen"),
    },

    // -------------------------------------------------------------------------
    // W = Window management (Rectangle + tabs/navigation)
    // -------------------------------------------------------------------------
    w: {
      // Rectangle window positioning
      h: rectangle("left-half"),
      j: rectangle("bottom-half"),
      k: rectangle("top-half"),
      l: rectangle("right-half"),
      f: rectangle("maximize"),
      y: rectangle("previous-display"),
      o: rectangle("next-display"),

      // Tab navigation
      u: {
        description: "Previous Tab",
        to: [{ key_code: "tab", modifiers: ["right_control", "right_shift"] }],
      },
      i: {
        description: "Next Tab",
        to: [{ key_code: "tab", modifiers: ["right_control"] }],
      },

      // Window navigation
      n: {
        description: "Next Window",
        to: [
          { key_code: "grave_accent_and_tilde", modifiers: ["right_command"] },
        ],
      },
      b: {
        description: "Back",
        to: [{ key_code: "open_bracket", modifiers: ["right_command"] }],
      },
      m: {
        description: "Forward",
        to: [{ key_code: "close_bracket", modifiers: ["right_command"] }],
      },
      semicolon: {
        description: "Hide Window",
        to: [{ key_code: "h", modifiers: ["right_command"] }],
      },
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
      global: { show_in_menu_bar: false },
      profiles: [
        {
          name: "Default",
          complex_modifications: { rules },
        },
      ],
    },
    null,
    2
  )
);
