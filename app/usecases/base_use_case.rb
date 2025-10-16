class BaseUseCase
    def self.call(*params)
        new(*params).call
    end

    def call
        raise NotImplementedError
    end
end