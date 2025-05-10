interface Theme {
  "color-scheme": string
  "--color-base-100": string
  "--color-base-200": string
  "--color-base-300": string
  "--color-base-content": string
  "--color-primary": string
  "--color-primary-content": string
  "--color-secondary": string
  "--color-secondary-content": string
  "--color-accent": string
  "--color-accent-content": string
  "--color-neutral": string
  "--color-neutral-content": string
  "--color-info": string
  "--color-info-content": string
  "--color-success": string
  "--color-success-content": string
  "--color-warning": string
  "--color-warning-content": string
  "--color-error": string
  "--color-error-content": string
  "--radius-selector": string
  "--radius-field": string
  "--radius-box": string
  "--size-selector": string
  "--size-field": string
  "--border": string
  "--depth": string
  "--noise": string
}


interface Themes {
  cyberpunk: Theme
  acid: Theme
  black: Theme
  dark: Theme
  light: Theme
  luxury: Theme
  dracula: Theme
  retro: Theme
  lofi: Theme
  valentine: Theme
  nord: Theme
  lemonade: Theme
  garden: Theme
  aqua: Theme
  corporate: Theme
  pastel: Theme
  bumblebee: Theme
  coffee: Theme
  silk: Theme
  sunset: Theme
  synthwave: Theme
  dim: Theme
  abyss: Theme
  forest: Theme
  night: Theme
  caramellatte: Theme
  autumn: Theme
  emerald: Theme
  cupcake: Theme
  cmyk: Theme
  business: Theme
  winter: Theme
  halloween: Theme
  fantasy: Theme
  wireframe: Theme
  [key: string]: Theme
}

declare const themes: Themes
export default themes