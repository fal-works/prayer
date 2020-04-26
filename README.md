# prayer

Utility library for Haxe macro.

**Requires Haxe 4** (developed with v4.0.5).


## Caveats

Reinventing the wheel!

Maybe you would prefer to use [tink_macro](https://github.com/haxetink/tink_macro) or any other library.


## Usage

```haxe
import prayer.*;

using prayer.extensions.Index;
```


## Classes

### ContextTools

Utility functions using `haxe.macro.Context`.

### ModuleTools

Utility functions for modules.

### Values

Some constant values.


## Types

### MacroResult

Enum, either
- `Ok(value: T)` or
- `Failed(message: String, position: haxe.macro.Expr.Position)`

Also has some additional methods.

### CompilerFlag

Object unit representing a compiler flag with a default value.

### ModuleInfo

Information about a module.

### EnumAbstractType

A kind of `haxe.macro.Type.AbstractType` instance that has `@:enum` metadata.

### Fields

Just an alias for `Array<haxe.macro.Expr.Field>`.


## Static extension

`using prayer.extensions.Index;`

The above enables you to use additional methods for several macro-related types  
(such as `Type`, `Expr`, `Field`, `ComplexType`, `ClassType` etc).


## Dependencies

- [sinker](https://github.com/fal-works/sinker) v0.1.0

See also:
[FAL Haxe libraries](https://github.com/fal-works/fal-haxe-libraries)
