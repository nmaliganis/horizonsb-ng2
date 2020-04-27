using System;
using System.Linq;
using System.Threading.Tasks;
using horizonsb.be.contracts.Categories;
using horizonsb.be.model.Categories;
using horizonsb.be.repository.ContractRepositories;
using horizonsb.common.infrastructure.Exceptions.Domain.Categories;
using horizonsb.common.infrastructure.Exceptions.Domain.Sports;
using horizonsb.common.infrastructure.TypeMappings;
using horizonsb.common.infrastructure.UnitOfWorks;
using horizonsb.commons.vm.Dtos.Categories;
using Serilog;

namespace horizonsb.be.services.Categories
{
  public class CreateCategoryProcessor : ICreateCategoryProcessor
  {
    private readonly IUnitOfWork _uOf;
    private readonly ICategoryRepository _categoryRepository;
    private readonly ISportRepository _sportRepository;
    private readonly IAutoMapper _autoMapper;

    public CreateCategoryProcessor(IUnitOfWork uOf, IAutoMapper autoMapper,
      ICategoryRepository categoryRepository, ISportRepository sportRepository)
    {
      _uOf = uOf;
      _categoryRepository = categoryRepository;
      _sportRepository = sportRepository;
      _autoMapper = autoMapper;
    }

    public Task<CategoryUiModel> CreateCategoryAsync(
      CategoryForCreationUiModel newCategoryUiModel)
    {
      var response =
        new CategoryUiModel()
        {
          Message = "START_CREATION"
        };

      if (newCategoryUiModel == null)
      {
        response.Message = "ERROR_INVALID_CATEGORY_MODEL";
        return Task.Run(() => response);
      }

      try
      {
        var categoryToBeCreated = new Category();

        categoryToBeCreated.InjectWithInitialAttributes(newCategoryUiModel);

        var sportToBeInjected = _sportRepository.FindBySportId(newCategoryUiModel.ParentSportId);

        if (sportToBeInjected == null)
          throw new SportDoesNotExistException(newCategoryUiModel.ParentSportId);

        categoryToBeCreated.InjectWithSport(sportToBeInjected);

        ThrowExcIfCategoryCannotBeCreated(categoryToBeCreated);
        ThrowExcIfThisCategoryAlreadyExist(categoryToBeCreated);

        Log.Information(
          $"Create Category: {newCategoryUiModel.Name}" +
          "--CreateCategory--  @NotComplete@ [CreateCategoryProcessor]. " +
          "Message: Just Before MakeItPersistence");

        MakeCategoryPersistent(categoryToBeCreated);

        Log.Information(
          $"Create Category: {newCategoryUiModel.Name}" +
          "--CreateCategory--  @NotComplete@ [CreateCategoryProcessor]. " +
          "Message: Just After MakeItPersistence");
        response.Message = "SUCCESS_CREATION";
      }
      catch (InvalidCategoryException e)
      {
        response.Message = "ERROR_INVALID_CATEGORY_MODEL";
        Log.Error(
          $"Create Category: {newCategoryUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateCategory--  @NotComplete@ [CreateCategoryProcessor]. " +
          $"Broken rules: {e.BrokenRules}");
      }
      catch (CategoryAlreadyExistsException ex)
      {
        response.Message = "ERROR_CATEGORY_ALREADY_EXISTS";
        Log.Error(
          $"Create Category: {newCategoryUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateCategory--  @fail@ [CreateCategoryProcessor]. " +
          $"@innerfault:{ex?.Message} and {ex?.InnerException}");
      }
      catch (CategoryDoesNotExistAfterMadePersistentException exx)
      {
        response.Message = "ERROR_CATEGORY_NOT_MADE_PERSISTENT";
        Log.Error(
          $"Create Category: {newCategoryUiModel.Name}" +
          $"Error Message:{response.Message}" +
          "--CreateCategory--  @fail@ [CreateCategoryProcessor]." +
          $" @innerfault:{exx?.Message} and {exx?.InnerException}");
      }
      catch (Exception exxx)
      {
        response.Message = "UNKNOWN_ERROR";
        Log.Error(
          $"Create Category: {newCategoryUiModel.Name}" +
          $"Error Message:{response.Message}" +
          $"--CreateCategory--  @fail@ [CreateCategoryProcessor]. " +
          $"@innerfault:{exxx.Message} and {exxx.InnerException}");
      }

      return Task.Run(() => response);
    }

    private void ThrowExcIfThisCategoryAlreadyExist(Category categoryToBeCreated)
    {
      var categoryRetrieved = _categoryRepository.FindByCategoryId(categoryToBeCreated.CategoryId);
      if (categoryRetrieved != null)
      {
        throw new CategoryAlreadyExistsException(categoryToBeCreated.Name,
          categoryToBeCreated.GetBrokenRulesAsString());
      }
    }

    private CategoryUiModel ThrowExcIfCategoryWasNotBeMadePersistent(Category categoryToBeCreated)
    {
      var retrievedCategory = _categoryRepository.FindByName(categoryToBeCreated.Name);
      if (retrievedCategory != null)
        return _autoMapper.Map<CategoryUiModel>(retrievedCategory);
      throw new CategoryDoesNotExistAfterMadePersistentException(categoryToBeCreated.Name);
    }

    private void ThrowExcIfCategoryCannotBeCreated(Category categoryToBeCreated)
    {
      bool canBeCreated = !categoryToBeCreated.GetBrokenRules().Any();
      if (!canBeCreated)
        throw new InvalidCategoryException(categoryToBeCreated.GetBrokenRulesAsString());
    }

    private void MakeCategoryPersistent(Category categoryToBeMadePersistence)
    {
      _categoryRepository.Save(categoryToBeMadePersistence);
      _uOf.Commit();
    }
  }
}
