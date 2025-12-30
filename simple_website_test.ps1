# Simple Website Test Script for Juniper Finance
Write-Host "🚀 Testing Juniper Finance Website" -ForegroundColor Green
Write-Host "=" * 50

$baseUrl = "https://juniperfinance.preview.emergentagent.com"

# Test 1: Frontend accessibility
Write-Host "`n📱 Testing Frontend..." -ForegroundColor Yellow
try {
    $frontendResponse = Invoke-WebRequest -Uri $baseUrl -UseBasicParsing -TimeoutSec 15
    Write-Host "✅ Frontend Status: $($frontendResponse.StatusCode)" -ForegroundColor Green
    
    # Check if it contains expected content
    if ($frontendResponse.Content -match "Juniper|Investment|Portfolio|Finance") {
        Write-Host "✅ Contains expected investment-related content" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Content may be loading dynamically" -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Frontend Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: API Endpoints
Write-Host "`n🔧 Testing API Endpoints..." -ForegroundColor Yellow
$apiEndpoints = @("profile", "testimonials", "insights", "performance")

foreach ($endpoint in $apiEndpoints) {
    try {
        $apiUrl = "$baseUrl/api/$endpoint"
        $apiResponse = Invoke-RestMethod -Uri $apiUrl -Method GET -TimeoutSec 10
        Write-Host "✅ $endpoint API - Working" -ForegroundColor Green
        
        # Show sample data
        if ($endpoint -eq "profile" -and $apiResponse.name) {
            Write-Host "   Name: $($apiResponse.name)" -ForegroundColor Cyan
        } elseif ($endpoint -eq "testimonials" -and $apiResponse.Count -gt 0) {
            Write-Host "   Found $($apiResponse.Count) testimonials" -ForegroundColor Cyan
        } elseif ($endpoint -eq "insights" -and $apiResponse.Count -gt 0) {
            Write-Host "   Found $($apiResponse.Count) insights" -ForegroundColor Cyan
        } elseif ($endpoint -eq "performance" -and $apiResponse.summary) {
            Write-Host "   YTD Return: $($apiResponse.summary.ytdReturn)" -ForegroundColor Cyan
        }
    } catch {
        Write-Host "❌ $endpoint API - Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Test 3: Contact Form
Write-Host "`n📧 Testing Contact Form..." -ForegroundColor Yellow
try {
    $contactData = @{
        name = "Test User $(Get-Date -Format 'HHmmss')"
        email = "test@example.com"
        phone = "+1-555-0123"
        investmentGoal = "Portfolio testing"
        message = "Automated test submission"
    } | ConvertTo-Json

    $contactResponse = Invoke-RestMethod -Uri "$baseUrl/api/contacts" -Method POST -Body $contactData -ContentType "application/json" -TimeoutSec 10
    Write-Host "✅ Contact Form - Working" -ForegroundColor Green
    Write-Host "   Contact ID: $($contactResponse.id)" -ForegroundColor Cyan
} catch {
    Write-Host "❌ Contact Form - Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 4: Check for FINRA compliance
Write-Host "`n🏛️  Testing FINRA Compliance..." -ForegroundColor Yellow
try {
    $profileResponse = Invoke-RestMethod -Uri "$baseUrl/api/profile" -Method GET -TimeoutSec 10
    if ($profileResponse.finraLink -and $profileResponse.finraLink -match "brokercheck.finra.org") {
        Write-Host "✅ FINRA BrokerCheck link present" -ForegroundColor Green
        Write-Host "   Link: $($profileResponse.finraLink)" -ForegroundColor Cyan
    } else {
        Write-Host "⚠️  FINRA link not found or invalid" -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Could not verify FINRA compliance" -ForegroundColor Red
}

Write-Host "`n" + "=" * 50
Write-Host "🎯 Test Summary Complete" -ForegroundColor Green
Write-Host "Visit the website: $baseUrl" -ForegroundColor Cyan