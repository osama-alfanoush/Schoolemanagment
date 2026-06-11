import React from "react";

interface State {
  error: Error | null;
}

export class ErrorBoundary extends React.Component<
  { children: React.ReactNode },
  State
> {
  state: State = { error: null };

  static getDerivedStateFromError(error: Error): State {
    return { error };
  }

  componentDidCatch(error: Error, info: React.ErrorInfo) {
    console.error("[ErrorBoundary] caught:", error, info);
  }

  handleReset = () => {
    this.setState({ error: null });
  };

  render() {
    if (this.state.error) {
      const isDev = import.meta.env.DEV;
      return (
        <div
          className="min-h-screen flex items-center justify-center p-8 bg-background"
          role="alert"
        >
          <div className="max-w-md w-full text-center space-y-4">
            <div className="text-4xl">⚠</div>
            <h1 className="text-xl font-semibold text-foreground">
              Something went wrong
            </h1>
            <p className="text-sm text-muted-foreground">
              An unexpected error occurred. Please try reloading.
            </p>
            {isDev && (
              <pre className="text-xs text-left whitespace-pre-wrap text-muted-foreground overflow-auto max-h-48 bg-muted p-3 rounded">
                {this.state.error.message}
              </pre>
            )}
            <div className="flex justify-center gap-3">
              <button
                className="px-4 py-2 bg-primary text-primary-foreground rounded-md text-sm hover:opacity-90"
                onClick={this.handleReset}
              >
                Try again
              </button>
              <button
                className="px-4 py-2 bg-muted text-foreground rounded-md text-sm hover:opacity-90"
                onClick={() => { window.location.href = "/"; }}
              >
                Go home
              </button>
            </div>
          </div>
        </div>
      );
    }
    return this.props.children;
  }
}
