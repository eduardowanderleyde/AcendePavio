# frozen_string_literal: true

# Schema GraphQL para o Blog API
# Desenvolvido por Eduardo Wanderley
# https://github.com/eduardowanderleyde

class MyGraphqlAppSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Para debug
  if Rails.env.development?
    max_depth 20
    max_complexity 300
  end

  # Configuração do GraphQL::Batch
  use GraphQL::Batch

  # Tratamento de erros
  rescue_from(StandardError) do |err, obj, args, ctx, field|
    Rails.logger.error(err)
    raise GraphQL::ExecutionError, "Ocorreu um erro ao processar sua requisição"
  end

  # Configurações para otimização de queries N+1
  use GraphQL::Batch

  # Tratamento de erros personalizado
  rescue_from(ActiveRecord::RecordNotFound) do |err, obj, args, ctx, field|
    raise GraphQL::ExecutionError, "#{field.type.unwrap.graphql_name} não encontrado"
  end

  rescue_from(ActiveRecord::RecordInvalid) do |err, obj, args, ctx, field|
    raise GraphQL::ExecutionError, err.record.errors.full_messages.join(", ")
  end

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    # if err.is_a?(GraphQL::InvalidNullError)
    #   # report to your bug tracker here
    #   return nil
    # end
    super
  end

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    # TODO: Implement this method
    # to return the correct GraphQL object type for `obj`
    raise(GraphQL::RequiredImplementationMissingError)
  end

  # Limit the size of incoming queries:
  max_query_string_tokens(5000)

  # Stop validating when it encounters this many errors:
  validate_max_errors(100)

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    object.to_gid_param
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    GlobalID.find(global_id)
  end
end
