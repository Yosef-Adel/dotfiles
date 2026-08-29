import { To, KeyCode, Manipulator, KarabinerRules, Modifiers } from "./types";

/**
 * Custom way to describe a command in a layer
 */
export interface LayerCommand {
  to: To[];
  description?: string;
  /**
   * Modifiers that must be held for this command to fire, e.g. Hyper + Shift + 1.
   * When a key has both a plain and a modified binding, list the modified one
   * FIRST -- Karabiner uses the first matching manipulator, and plain bindings
   * match with `optional: ["any"]`, so they would otherwise swallow the variant.
   */
  modifiers?: Modifiers;
}

/** One key may carry several bindings, differentiated by mandatory modifiers. */
type LayerBinding = LayerCommand | LayerCommand[];

type HyperKeySublayer = {
  // The ? is necessary, otherwise we'd have to define something for _every_ key code
  [key_code in KeyCode]?: LayerBinding;
};

/** Normalises the single-or-many shape into an array. */
function toCommands(binding: LayerBinding): LayerCommand[] {
  return Array.isArray(binding) ? binding : [binding];
}

/** Builds the `from.modifiers` for a command, defaulting to "any optional". */
function fromModifiers(command: LayerCommand): Modifiers {
  return command.modifiers
    ? { ...command.modifiers, optional: command.modifiers.optional ?? ["any"] }
    : { optional: ["any"] };
}

/**
 * Create a Hyper Key sublayer, where every command is prefixed with a key
 * e.g. Hyper + O ("Open") is the "open applications" layer, I can press
 * e.g. Hyper + O + G ("Google Chrome") to open Chrome
 */
export function createHyperSubLayer(
  sublayer_key: KeyCode,
  commands: HyperKeySublayer,
  allSubLayerVariables: string[]
): Manipulator[] {
  const subLayerVariableName = generateSubLayerVariableName(sublayer_key);

  return [
    // When Hyper + sublayer_key is pressed, set the variable to 1; on key_up, set it to 0 again
    {
      description: `Toggle Hyper sublayer ${sublayer_key}`,
      type: "basic",
      from: {
        key_code: sublayer_key,
        modifiers: {
          optional: ["any"],
        },
      },
      to_after_key_up: [
        {
          set_variable: {
            name: subLayerVariableName,
            // The default value of a variable is 0: https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/conditions/variable/
            // That means by using 0 and 1 we can filter for "0" in the conditions below and it'll work on startup
            value: 0,
          },
        },
      ],
      to: [
        {
          set_variable: {
            name: subLayerVariableName,
            value: 1,
          },
        },
      ],
      // This enables us to press other sublayer keys in the current sublayer
      // (e.g. Hyper + O > M even though Hyper + M is also a sublayer)
      // basically, only trigger a sublayer if no other sublayer is active
      conditions: [
        ...allSubLayerVariables
          .filter(
            (subLayerVariable) => subLayerVariable !== subLayerVariableName
          )
          .map((subLayerVariable) => ({
            type: "variable_if" as const,
            name: subLayerVariable,
            value: 0,
          })),
        {
          type: "variable_if",
          name: "hyper",
          value: 1,
        },
      ],
    },
    // Define the individual commands that are meant to trigger in the sublayer
    ...(Object.keys(commands) as (keyof typeof commands)[]).flatMap(
      (command_key): Manipulator[] =>
        toCommands(commands[command_key]!).map(
          ({ modifiers, ...command }): Manipulator => ({
            ...command,
            type: "basic" as const,
            from: {
              key_code: command_key,
              modifiers: fromModifiers({ ...command, modifiers }),
            },
            // Only trigger this command if the variable is 1 (i.e., if Hyper + sublayer is held)
            conditions: [
              {
                type: "variable_if",
                name: subLayerVariableName,
                value: 1,
              },
            ],
          })
        )
    ),
  ];
}

/**
 * Create all hyper sublayers. This needs to be a single function, as well need to
 * have all the hyper variable names in order to filter them and make sure only one
 * activates at a time
 */
export function createHyperSubLayers(subLayers: {
  [key_code in KeyCode]?: HyperKeySublayer | LayerBinding;
}): KarabinerRules[] {
  const allSubLayerVariables = (
    Object.keys(subLayers) as (keyof typeof subLayers)[]
  ).map((sublayer_key) => generateSubLayerVariableName(sublayer_key));

  return Object.entries(subLayers).map(([key, value]) =>
    isLayerBinding(value)
      ? {
          description: `Hyper Key + ${key}`,
          manipulators: toCommands(value).map(({ modifiers, ...command }) => ({
            ...command,
            type: "basic" as const,
            from: {
              key_code: key as KeyCode,
              modifiers: fromModifiers({ ...command, modifiers }),
            },
            conditions: [
              {
                type: "variable_if" as const,
                name: "hyper",
                value: 1,
              },
              ...allSubLayerVariables.map((subLayerVariable) => ({
                type: "variable_if" as const,
                name: subLayerVariable,
                value: 0,
              })),
            ],
          })),
        }
      : {
          description: `Hyper Key sublayer "${key}"`,
          manipulators: createHyperSubLayer(
            key as KeyCode,
            value,
            allSubLayerVariables
          ),
        }
  );
}

function generateSubLayerVariableName(key: KeyCode) {
  return `hyper_sublayer_${key}`;
}

/** Distinguishes a leaf binding (one or more commands) from a nested sublayer. */
function isLayerBinding(
  value: HyperKeySublayer | LayerBinding
): value is LayerBinding {
  return Array.isArray(value) || "to" in value;
}

/**
 * Shortcut for "open" shell command
 */
export function open(...what: string[]): LayerCommand {
  return {
    to: what.map((w) => ({
      shell_command: `open ${w}`,
    })),
    description: `Open ${what.join(" & ")}`,
  };
}

/**
 * Utility function to create a LayerCommand from a tagged template literal
 * where each line is a shell command to be executed.
 */
export function shell(
  strings: TemplateStringsArray,
  ...values: any[]
): LayerCommand {
  const commands = strings.reduce((acc, str, i) => {
    const value = i < values.length ? values[i] : "";
    const lines = (str + value)
      .split("\n")
      .filter((line) => line.trim() !== "");
    acc.push(...lines);
    return acc;
  }, [] as string[]);

  return {
    to: commands.map((command) => ({
      shell_command: command.trim(),
    })),
    description: commands.join(" && "),
  };
}

/** Absolute path -- Karabiner runs shell commands with a minimal PATH. */
const YABAI = "/opt/homebrew/bin/yabai";

/**
 * Shortcut for driving yabai. Each argument is run as its own `yabai -m ...`
 * invocation, so multi-step actions (e.g. toggle float then center) compose.
 */
export function yabai(...args: string[]): LayerCommand {
  return {
    to: args.map((arg) => ({ shell_command: `${YABAI} -m ${arg}` })),
    description: `yabai: ${args.join(" ; ")}`,
  };
}

/**
 * yabai command that falls back to a second command when the first fails --
 * used for directional actions at the edge of a space, where e.g. there is no
 * window to the west and we want to wrap around to the east instead.
 */
export function yabaiOr(primary: string, fallback: string): LayerCommand {
  return {
    to: [
      {
        shell_command: `${YABAI} -m ${primary} || ${YABAI} -m ${fallback}`,
      },
    ],
    description: `yabai: ${primary} (or ${fallback})`,
  };
}

/**
 * Shortcut for "Open an app" command (of which there are a bunch)
 */
export function app(name: string): LayerCommand {
  return open(`-a '${name}.app'`);
}
