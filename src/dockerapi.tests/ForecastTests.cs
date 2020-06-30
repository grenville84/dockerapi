using System.Linq;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;
using src.Controllers;

namespace dockerapi.tests
{
    public class ForecastTests
    {
        private readonly WeatherForecastController _weatherForecastController;
        private readonly Mock<ILogger<WeatherForecastController>> _logger;

        public ForecastTests()
        {
            _logger = new Mock<ILogger<WeatherForecastController>>();
            _weatherForecastController = new WeatherForecastController(_logger.Object);
        }

        [SetUp]
        public void Setup()
        {
            
        }

        [Test]
        public void GetsFiveItems()
        {
            var report = _weatherForecastController.Get();

            Assert.AreEqual(5, report.Count());
        }
    }
}