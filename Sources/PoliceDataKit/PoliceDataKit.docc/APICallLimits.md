# API Call Limits

Information about call limits to the Police API.

## Overview

The Police API call limit operates using a 'leaky bucket' algorithm as a controller. This allows for infrequent bursts
of calls, and allows you to continue to make an unlimited amount of calls over time.

### Rate Limit

The current rate limit is **15 requests per second** with a burst of 30. So, on average you must make fewer than 15
requests each second, but you can make up to 30 in a single second.

### Find Out More

You can learn more about the leaky bucket algorithm, see
[Wikipedia: Leaky bucket](https://en.wikipedia.org/wiki/Leaky_bucket).
