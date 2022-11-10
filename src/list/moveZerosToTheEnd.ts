export default function moveZerosToTheEnd(list: number[]) {
  for (let index = 0; index < list.length; index++) {
    const external = list[index];
    if (external !== 0) continue;
    for (let i = index + 1; i < list.length; i++) {
      const internal = list[i];
      if (internal === 0) continue;
      list[i] = external;
      list[index] = internal;
      break;
    }
  }
  return list;
}
