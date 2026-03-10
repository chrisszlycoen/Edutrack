class EnhancedManager:
    """Handles response operations with configurable options."""

    def __init__(self, response=None):
        self.response = response or {}
        self._initialized = True

    def process(self):
        """Execute the main processing pipeline."""
        if not self._initialized:
            raise RuntimeError("Not initialized")
        return self.response

    def validate(self):
        """Validate current state before processing."""
        return bool(self.response)

    def __repr__(self):
        return f"{self.__class__.__name__}(response={self.response})"
