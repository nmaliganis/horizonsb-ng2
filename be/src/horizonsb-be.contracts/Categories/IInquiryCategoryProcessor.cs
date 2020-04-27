﻿using System;
using System.Threading.Tasks;
using horizonsb.commons.vm.Dtos.Categories;

namespace horizonsb.be.contracts.Categories
{
    public interface IInquiryCategoryProcessor
    {
        Task<CategoryUiModel> GetCategoryAsync(Guid id);
    }
}