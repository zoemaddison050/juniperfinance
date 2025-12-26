# API Contracts - Juniper Broz Investment Portfolio

## Overview
This document outlines the backend API contracts for the investment portfolio website.

## Current Mock Data (in `/src/data/mockData.js`)

| Data | Description | Backend Required |
|------|-------------|------------------|
| `profileData` | Name, title, contact info, stats | Yes - Site settings |
| `philosophyPoints` | Investment philosophy items | Yes - CMS editable |
| `services` | Service offerings | Yes - CMS editable |
| `performanceData` | Charts, stats, allocation | Yes - Editable metrics |
| `insights` | Blog/articles | Yes - Full CRUD |
| `testimonials` | Client reviews | Yes - Full CRUD |
| `credentials` | Professional certifications | Yes - CMS editable |
| `navLinks` | Navigation items | No - Static |

## API Endpoints

### 1. Contact Form Submissions
```
POST /api/contacts
Body: { name, email, phone, investmentGoal, message }
Response: { id, ...data, timestamp, status }

GET /api/contacts (admin)
Response: [{ id, name, email, phone, investmentGoal, message, timestamp, status }]
```

### 2. Site Profile/Settings
```
GET /api/profile
Response: { name, title, tagline, description, finraLink, email, whatsapp, telegram, yearsExperience, clientsServed, assetsManaged, socialLinks }

PUT /api/profile (admin)
Body: { ...profileFields }
```

### 3. Testimonials
```
GET /api/testimonials
Response: [{ id, name, role, content, rating, isActive }]

POST /api/testimonials
PUT /api/testimonials/:id
DELETE /api/testimonials/:id
```

### 4. Insights/Blog
```
GET /api/insights
Response: [{ id, title, excerpt, content, category, date, readTime, isPublished }]

POST /api/insights
PUT /api/insights/:id
DELETE /api/insights/:id
```

### 5. Performance Data
```
GET /api/performance
Response: { summary: {...}, chartData: [...], allocation: [...], disclaimer }

PUT /api/performance (admin)
```

## MongoDB Collections

1. **contacts** - Form submissions
2. **profile** - Single document for site settings
3. **testimonials** - Client reviews
4. **insights** - Blog articles
5. **performance** - Performance metrics (single document)

## Frontend Integration Points

| Component | Current Source | Backend Endpoint |
|-----------|---------------|------------------|
| Hero.jsx | mockData.profileData | GET /api/profile |
| About.jsx | mockData.profileData, credentials | GET /api/profile |
| Testimonials.jsx | mockData.testimonials | GET /api/testimonials |
| Insights.jsx | mockData.insights | GET /api/insights |
| Performance.jsx | mockData.performanceData | GET /api/performance |
| Contact.jsx | localStorage | POST /api/contacts |
| Header/Footer | mockData.profileData | GET /api/profile |

## Implementation Priority

1. **Phase 1 (Core)**: Contact form submission, Profile API
2. **Phase 2 (Content)**: Testimonials, Insights CRUD
3. **Phase 3 (Analytics)**: Performance data management
