export interface qrdniPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
