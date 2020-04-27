using System.Threading.Tasks;
using horizonsb.api.Redis.Logs;
using horizonsb.common.infrastructure.PropertyMappings;
using horizonsb.common.infrastructure.PropertyMappings.TypeHelpers;
using Microsoft.AspNetCore.Mvc;

namespace horizonsb.api.Controllers.API
{
    [Produces("application/json")]
    [ResponseCache(Duration = 0, NoStore = true, VaryByHeader = "*")]
    [Route("api/[controller]")]
    [ApiController]
    public class LogsController : ControllerBase
    {
        private readonly IUrlHelper _urlHelper;
        private readonly ITypeHelperService _typeHelperService;
        private readonly IPropertyMappingService _propertyMappingService;

        private readonly ILogRedisRepository _redisRepository;


        public LogsController(IUrlHelper urlHelper,
            ILogRedisRepository redisRepository)
        {
            _urlHelper = urlHelper;
            _redisRepository = redisRepository;
        }
        
        [HttpGet(Name = "GetLog")]
        public async Task<IActionResult> GetLogRoot()
        {
            var logRedis = await _redisRepository.GetLogAsync();
            return Ok(logRedis);
        }
        [HttpPost(Name = "SetLog")]
        public async Task<IActionResult> SetLogRoot([FromBody] LogRedis logRedisToBeUpdated)
        {
            var logRedisToHaveBeenCreated = await _redisRepository.UpdateLogAsync(logRedisToBeUpdated);

            var logRedis = await _redisRepository.GetLogAsync();
            return Ok(logRedis);
        }
    }
}
