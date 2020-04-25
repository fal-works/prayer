package prayer;

#if macro
import prayer.Types.ModuleInfo;
import prayer.Types.DefinedType;

class ModuleTools {
	/**
		Define new imports in the current module in which the macro was called.
	**/
	public static function defineImports(importExpressions: Array<ImportExpr>): Void {
		Context.defineModule(
			Context.getLocalModule(),
			[],
			Context.getLocalImports().concat(importExpressions),
			Context.getLocalUsing().map(MacroCaster.ClassTypeCaster.refToTypePath)
		);
	}

	/**
		Formats `modulePath`.
		@return `ModuleInfo` object.
	**/
	public static function getModuleInfo(modulePath: String): ModuleInfo {
		final modulePathLastDotIndex = modulePath.getLastIndexOfDot();
		final moduleName = modulePath.substr(modulePathLastDotIndex + 1);
		var packagePath: String;
		var packages: Array<String>;
		if (modulePathLastDotIndex.isSome()) {
			packagePath = modulePath.substr(0, modulePathLastDotIndex.unwrap());
			packages = packagePath.split(".");
		} else {
			packagePath = "";
			packages = [];
		}

		return {
			path: modulePath,
			name: moduleName,
			packagePath: packagePath,
			packages: packages
		};
	}

	/**
		@return Information about the current module and package
		in which the macro was called.
	**/
	public static function getLocalModuleInfo(): ModuleInfo
		return getModuleInfo(Context.getLocalModule());

	/**
		Defines `typeDefinition` as a sub-type in the current module in which the macro was called.
		@return `path`: TypePath of the type. `pathString`: Dot-separated path of the type.
	**/
	public static function defineSubTypes(
		typeDefinitions: Array<TypeDefinition>
	): Array<DefinedType> {
		final localModule = getLocalModuleInfo();

		Context.defineModule(
			Context.getLocalModule(),
			typeDefinitions,
			Context.getLocalImports(),
			Context.getLocalUsing().map(MacroCaster.ClassTypeCaster.refToTypePath)
		);

		final definedTypes: Array<DefinedType> = [];

		for (i in 0...typeDefinitions.length) {
			final typeDefinition = typeDefinitions[i];

			typeDefinition.pack = localModule.packages;

			final subTypeName = typeDefinition.name;

			final path: TypePath = {
				pack: localModule.packages,
				name: localModule.name,
				sub: subTypeName
			};

			final definedType: DefinedType = {
				path: path,
				pathString: '${localModule.path}.${subTypeName}',
				complex: TPath(path)
			};
			definedTypes.push(definedType);
		}

		return definedTypes;
	}
}
#end
