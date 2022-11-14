export type Minefield = Array<number[]>;

export default function findMineLocation(minefield: Minefield): [row: number, column: number] {
  for (let index = 0; index < minefield.length; index++) {
    const column = minefield[index].indexOf(1);
    if (column > -1) return [index, column];
  }
  throw new Error("Field does not contain a bomb! (Lucky!)");
}
