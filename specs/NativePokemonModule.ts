import type {TurboModule} from 'react-native';
import {TurboModuleRegistry} from 'react-native';

export interface Spec extends TurboModule {
  setFavorite(favorite: boolean): void;
  exit(): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'NativePokemonModule',
);
