import { toNATO } from "@string";

const str = toNATO("lmao");

it("Should return a string", () => {
  expect(str).toBeTypeOf("string");
});

it("Should replace each letter with the NATO dictionary", () => {
  expect(str).toBe("Lima Mike Alfa Oscar");
  expect(toNATO("ayy lmao")).toBe("Alfa Yankee Yankee Lima Mike Alfa Oscar");
  expect(toNATO("bob")).toBe("Bravo Oscar Bravo");
  expect(toNATO("tlapa")).toBe("Tango Lima Alfa Papa Alfa");
});

it("Should reduce whitespace to only one space", () => {
  expect(toNATO("a   lot    of")).toBe("Alfa Lima Oscar Tango Oscar Foxtrot");
});

it("Should preserve non-alphabet characters", () => {
  expect(toNATO("a   lot    of!")).toBe("Alfa Lima Oscar Tango Oscar Foxtrot !");
  expect(toNATO("you can't hurt me, jack!")).toBe(
    "Yankee Oscar Uniform Charlie Alfa November ' Tango Hotel Uniform Romeo Tango Mike Echo , Juliett Alfa Charlie Kilo !"
  );
  expect(toNATO("nanomachines, son")).toBe(
    "November Alfa November Oscar Mike Alfa Charlie Hotel India November Echo Sierra , Sierra Oscar November"
  );
});
