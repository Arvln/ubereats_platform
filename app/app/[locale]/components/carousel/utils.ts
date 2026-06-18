import { TCarousel } from "types/features";

export const GROUP_SIZE = 3;
export const WINDOW_GROUPS = 3; // previous + current + next
export const WINDOW_SIZE = GROUP_SIZE * WINDOW_GROUPS; // always 9 <li> nodes

export type TWindowItem = TCarousel & {
  /** Stable position in the 9-slot window (0-8); used as the React key so the
   * DOM keeps exactly 9 <li> nodes and only swaps their image source. */
  slot: number;
  /** Index into the original carousel data this slot currently points to. */
  dataIndex: number;
};

/** Positive modulo so negative indices wrap to the end of the data. */
export function wrapIndex(index: number, length: number): number {
  if (length <= 0) return 0;
  return ((index % length) + length) % length;
}

/**
 * Builds the 9-item window for the current position: the previous group, the
 * current (visible) group, and the next group, three items each. Indices wrap
 * around the data so the carousel loops infinitely while the DOM never holds
 * more than WINDOW_SIZE nodes.
 */
export function getRenderWindow(
  data: TCarousel[],
  currentIndex: number
): TWindowItem[] {
  if (data.length === 0) return [];

  const window: TWindowItem[] = [];
  const start = currentIndex - GROUP_SIZE; // begin at the previous group

  for (let slot = 0; slot < WINDOW_SIZE; slot++) {
    const dataIndex = wrapIndex(start + slot, data.length);
    window.push({ ...data[dataIndex], slot, dataIndex });
  }

  return window;
}
